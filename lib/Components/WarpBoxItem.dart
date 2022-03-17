import 'package:flutter/material.dart';
import 'package:cloudinary_sdk/cloudinary_sdk.dart';

//String transformedUrl = "https://res.cloudinary.com/di6dsngnr/image/upload/v1647419888/bkdms/gqavvlhamwvsobpofqu7.jpg";
class TestContainerItem extends StatelessWidget {
    late String? linkImg; 
    late int? numberOfTotalItem; 
    late String? priceAgency;
    late String? nameItem;

    // Constructor
    TestContainerItem(this.linkImg,this.numberOfTotalItem,this.priceAgency, this.nameItem); 

    @override
    Widget build(BuildContext context) {
        double widthDevice = MediaQuery.of(context).size.width;// chiều rộng thiết bị
        return SizedBox(
            height: 700,
            width: widthDevice*0.95,
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1/1.2,
                ),
                padding: EdgeInsets.all(8),
                primary: false,
                itemCount: numberOfTotalItem,
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
                                        getUrlFromLinkImg("$linkImg"),
                                        width: widthDevice*0.38,                     
                                    ),
                                    //Tên sản phẩm
                                    SizedBox(
                                        height: 30 ,
                                        width: widthDevice*0.4,
                                        child: Text(
                                            "$nameItem",
                                            maxLines: 2, 
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(fontSize: 13),
                                        )
                                    ),
                                    // Price Agency
                                    SizedBox(
                                        height: 20,
                                        width: widthDevice*0.4,
                                        child: Text(
                                          "$priceAgency" + 'đ̳',
                                          style: TextStyle(fontSize:16, color: Color(0xffb01313))
                                        ) 
                                    )
                                ]
                            )
                        )
                      );
                },
        )
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