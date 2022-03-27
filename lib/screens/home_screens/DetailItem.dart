import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:bkdms/components/AppBarGrey.dart';
import 'package:bkdms/services/ItemProvider.dart';
import 'package:bkdms/models/Item.dart';


class DetailItem extends StatelessWidget {
  //late Item myItem;
  //late var baseUnit;
  //late List<dynamic> switchUnit;
  //DetailItem(this.myItem, this.baseUnit, this.switchUnit);
  static const lightGrey = Color(0xfffafafa);
  static const greyText = Color(0xff544c4c);

  @override
  Widget build(BuildContext context) {
    double widthDevice = MediaQuery.of(context).size.width;// chiều rộng thiết bị
    double myWidth = widthDevice*0.9; // chiều rộng hàng ngoài cùng(tê, giá sp, thông tin chi tiết,...)
    return Scaffold(
      appBar: AppBarGrey("Chi tiết sản phẩm"),
      backgroundColor: Color(0xfff0ecec),
      body: Consumer<ItemProvider>( builder: (ctxItemProvider, itemProvider, child) {
        
        return SingleChildScrollView( 
          child: Center(
            child: Column(
                children: [
                  // container đầu chứa ảnh + tên + VAT
                  Container(
                    height: 280,
                    width: widthDevice,
                    color: Colors.white,
                     child: Column(
                       children:[
                         //ảnh sản phẩm
                         Image.network(
                           // getUrlFromLinkImg("${myItem.linkImg}"),
                            getUrlFromLinkImg("bkdms/q9ldvcf3az15b8jmmvyy"),
                            width: widthDevice * 0.8,
                            height: 220,
                         ),
                         // tên sản phẩm
                         SizedBox(
                            width: myWidth,
                            child: Text(
                              "Smart Tivi LG 43 inch 43LH605T",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: TextStyle(
                                 fontSize: 18,
                                 fontWeight: FontWeight.w600,
                              ),
                          ),
                         ),
                         // VAT 8%
                         SizedBox(height: 5,),
                         SizedBox(
                            width: myWidth,
                            child: Text(
                              "VAT 8%",
                              style: TextStyle(
                                 fontSize: 16,
                                 fontWeight: FontWeight.w300,
                                 color: Color(0xfff53838),
                              ),
                          ),
                        )
                       ]
                     ),
                  ),
                  
                  // Container chứa giá sản phẩm
                  SizedBox(height: 12,),
                  Container(
                    width: widthDevice,
                    height: 180,
                    color: Colors.white,
                    child: Column(
                      children: [
                        SizedBox(height: 5,),
                        // text giá sản phẩm
                        Container(
                          width: myWidth,
                          child: Text("Giá sản phẩm", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),),
                        ),
                        SizedBox(height: 5,),
                        //text lưu ý giá sản phẩm đã bao gồm VAT
                        Container(
                          width: myWidth*0.9,
                          height: 35,
                          color: lightGrey,
                          child: Row(
                            children: [
                              SizedBox(width: 5,),
                              Text("Lưu ý giá sản phẩm đã bao gồm VAT", style: TextStyle(color: greyText),),
                            ],
                          )  
                        ),
                        // Radio các loại đơn vị
                        Container(
                          width: myWidth*0.9,
                          height: 35,
                          child: Row(
                            children: [
                              SizedBox(width: 5,),
                              Text("Đơn vị", style: TextStyle(color: greyText),),
                            ],
                          )  
                        ),                        
                        // Đơn giá
                        Container(
                          width: myWidth*0.9,
                          height: 35,
                          color: lightGrey,
                          child: Row(
                            children: [
                              SizedBox(width: 5,),
                              SizedBox(
                                width: myWidth*0.35,
                                child: Text("Đơn giá", style: TextStyle(color: greyText),),
                              ),
                              SizedBox(
                                width: myWidth*0.5,
                                child: Text("10000000000"),
                              )
                            ],
                          )  
                        ),                        
                        // Giá bán lẻ đề nghị
                        Container(
                          width: myWidth*0.9,
                          height: 35,
                          child: Row(
                            children: [
                              SizedBox(width: 5,),
                              SizedBox(
                                width: myWidth*0.35,
                                child: Text("Giá bán lẻ đề nghị", style: TextStyle(color: greyText),),
                              ),
                              SizedBox(
                                width: myWidth*0.5,
                                child: Text("10000000000---------", style: TextStyle(fontWeight: FontWeight.w600),),
                              )
                            ],
                          )  
                        ),                        
                                     
                      ],
                    ),
                  ),
                
                  // Container chứa thông tin chi tiết
                  SizedBox(height: 12,),
                  Container(
                    width: widthDevice,
                    height: 180,
                    color: Colors.white,
                    child: Column(
                      children: [
                        SizedBox(height: 5,),
                        // text giá sản phẩm
                        Container(
                          width: myWidth,
                          child: Text("Thông tin chi tiết", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),),
                        ),
                        SizedBox(height: 5,),
                        //text lưu ý giá sản phẩm đã bao gồm VAT
                        Container(
                          width: myWidth*0.9,
                          height: 35,
                          color: lightGrey,
                          child: Row(
                            children: [
                              SizedBox(width: 5,),
                              Text("Lưu ý giá sản phẩm đã bao gồm VAT", style: TextStyle(color: greyText),),
                            ],
                          )  
                        ),
                        // Radio các loại đơn vị
                        Container(
                          width: myWidth*0.9,
                          height: 35,
                          child: Row(
                            children: [
                              SizedBox(width: 5,),
                              Text("Đơn vị", style: TextStyle(color: greyText),),
                            ],
                          )  
                        ),                        
                        // Đơn giá
                        Container(
                          width: myWidth*0.9,
                          height: 35,
                          color: lightGrey,
                          child: Row(
                            children: [
                              SizedBox(width: 5,),
                              SizedBox(
                                width: myWidth*0.35,
                                child: Text("Đơn giá", style: TextStyle(color: greyText),),
                              ),
                              SizedBox(
                                width: myWidth*0.5,
                                child: Text("10000000000"),
                              )
                            ],
                          )  
                        ),                        
                        // Giá bán lẻ đề nghị
                        Container(
                          width: myWidth*0.9,
                          height: 35,
                          child: Row(
                            children: [
                              SizedBox(width: 5,),
                              SizedBox(
                                width: myWidth*0.35,
                                child: Text("Giá bán lẻ đề nghị", style: TextStyle(color: greyText),),
                              ),
                              SizedBox(
                                width: myWidth*0.5,
                                child: Text("10000000000---------", style: TextStyle(fontWeight: FontWeight.w600),),
                              )
                            ],
                          )  
                        ),                        
                                     
                      ],
                    ),
                  )
 
                ],
            )
          )
        );
      }),
      bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [ BoxShadow(
                   color: Colors.grey,
                   blurRadius: 5.0,
                   spreadRadius: 0.0,
                   offset: Offset(2.0, 2.0), // shadow direction: bottom right
                )],
              ),
              width: widthDevice,
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 7,),
                        SizedBox(
                          width: widthDevice*0.8,
                          height: 35,
                          child: ElevatedButton(
                              onPressed: () {
                                  //Navigator.push(context, MaterialPageRoute(builder: (context) => ScanItem()));
                              },
                              style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0),
                                  backgroundColor: MaterialStateProperty.all < Color > (Color(0xff4690FF)),
                                  shape: MaterialStateProperty.all < RoundedRectangleBorder > (
                                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0), )
                                  )
                              ),
                              child: Text("Chọn mua", style: TextStyle(fontWeight: FontWeight.w700), )
                          )  
                        ),
                        SizedBox(height: 5,),
                      ])
              )          
    );
  }

  // hàm lấy ảnh từ cloudinary
  String getUrlFromLinkImg(String linkImg) {
        final cloudinary = Cloudinary("975745475279556", "S9YIG_sABPRTmZKb0mGNTiJsAkg", "di6dsngnr");
        //linkImg receive from server as Public Id
        final cloudinaryImage = CloudinaryImage.fromPublicId("di6dsngnr", linkImg);
        String transformedUrl = cloudinaryImage.transform().width(256).thumb().generate()!;
        return transformedUrl;
  }
}