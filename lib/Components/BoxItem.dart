import 'package:bkdms/models/Item.dart';
import 'package:flutter/material.dart';
import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:bkdms/models/ItemTest.dart';



//class Box Item return a GridView of Item
class BoxItem extends StatelessWidget {

   
    // Constructor
  List<ItemTest> lstItem = [ItemTest("bkdms/moxdwpn5vrir9vndu5p8","Bột giặt omo siêu cấp vip pro trắng tinh khôi đến từ Mỹ Nga Nhật Úc","25000"),
                           ItemTest("bkdms/nvpfklknrimz4cia1b3o","Nước rửa chén SunLight","18000"),
                           ItemTest("bkdms/yjws4912tr7djcm4xvi6","Xà phòng Camay","6000"),
                           ItemTest("bkdms/q9ldvcf3az15b8jmmvyy","Nước lau nhà LightHouse","30000")].cast<ItemTest>();

    @override
    Widget build(BuildContext context) {
        double widthDevice = MediaQuery.of(context).size.width;// chiều rộng thiết bị
        return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                    childAspectRatio: 1/1.2,
                ),
                padding: EdgeInsets.all(8),
                primary: false,
                itemCount: lstItem.length,
                itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {
                            print("click sản phẩm");
                        },
                        child: Container(
                            color: Colors.white,
                            child: Column(
                                children: [
                                    Image.network(
                                        getUrlFromLinkImg("${lstItem[index].linkImg}"),
                                        width: widthDevice*0.38,                     
                                    ),
                                    //Tên sản phẩm
                                    SizedBox(
                                        height: 32 ,
                                        width: widthDevice*0.4,
                                        child: Text(
                                            "${lstItem[index].nameItem}",
                                            maxLines: 2, 
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: false,
                                            style: TextStyle(fontSize: 12),
                                        )
                                    ),
                                    // Price Agency
                                    SizedBox(
                                        height: 25,
                                        width: widthDevice*0.4,
                                        child: Text(
                                          "${lstItem[index].priceAgency}" + 'đ̳',
                                          style: TextStyle(fontSize:16, color: Color(0xffb01313))
                                        ) 
                                    ),
                                ]
                            )
                        )
                      );
                },
        
        );
    }

    //function return network link of image
    String getUrlFromLinkImg(String linkImg) {
        final cloudinary = Cloudinary("975745475279556", "S9YIG_sABPRTmZKb0mGNTiJsAkg", "di6dsngnr");
        //linkImg receive from server as Public Id
        final cloudinaryImage = CloudinaryImage.fromPublicId("di6dsngnr", linkImg);
        String transformedUrl = cloudinaryImage.transform().width(256).thumb().generate()!;
        return transformedUrl;
    }
}