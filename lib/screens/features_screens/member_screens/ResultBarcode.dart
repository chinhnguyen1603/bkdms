import 'dart:async';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:bkdms/services/ItemProvider.dart';
import 'package:bkdms/models/Item.dart';
import 'package:bkdms/screens/home_screens/HomePage.dart';

class ResultBarcode extends StatefulWidget {
  late Item receiveItem;
  ResultBarcode(this.receiveItem);
  List<Item> resultItem = [];

  @override
  State<ResultBarcode> createState() => ResultBarcodeState();
}




class ResultBarcodeState extends State<ResultBarcode> {
  List<Item> resultItem = [];
  String _scanBarcode = '';
  bool isShowDialog = true;
  int needShowDialog = 1;
  // tổng tiền
  int sumOfOrder = 0;

  @override
  void initState() {
    super.initState();
    resultItem.add(widget.receiveItem);
    // tổng tiền của đơn hàng
    sumOfOrder = int.parse(widget.receiveItem.retailPrice);
  }

  @override
  Widget build(BuildContext context) {
    double widthDevice = MediaQuery.of(context).size.width;// chiều rộng thiết bị
    double heightDevice = MediaQuery.of(context).size.height;// chiều cao thiết bị
    double myWidth = widthDevice*0.96;
    //thêm dấu chấm vào giá sản phẩm
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    String Function(Match) mathFunc = (Match match) => '${match[1]}.';


    return Scaffold(
      //appbar chứa icon plus để quét sản phẩm
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Color(0xff105480),),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: () async {
                await scanBarcodeNormal();
                for (var item in Provider.of<ItemProvider>(context, listen: false).lstItem){
                  if(_scanBarcode == item.barcode){
                    setState(() {
                      needShowDialog = 0;
                      sumOfOrder = sumOfOrder + int.parse(item.retailPrice);
                      print(sumOfOrder);
                    });
                    resultItem.add(item);
                    break;
                  } else{
                      needShowDialog = 1;
                  }       
                }
                if(needShowDialog == 0) {
                    setState(() {
                       isShowDialog = false;
                    }); 
                }
                else {
                    setState(() {
                       isShowDialog = true;
                    });                   
                }
                if(_scanBarcode != "-1") {
                 isShowDialog
                  ? showDialog(
                        context: context, 
                        builder: (ctx1) => AlertDialog(
                          title: Text("Thông báo", style: TextStyle(fontSize: 22),),
                          content: Text("Sản phẩm đã quét không thuộc danh mục của công ty", style: TextStyle(color: Color(0xff544c4c)),),
                          actions: [TextButton(
                             onPressed: () => Navigator.pop(ctx1),
                             child: Center (child: const Text(
                               'OK',
                               style: TextStyle(decoration: TextDecoration.underline,),
                             ),)
                           ),                      
                          ],                                      
                        )
                      )
                  : Text("");
                }
            },
            //icon plus
            icon: Icon(
              Icons.add,
              color: Color(0xff105480),
              size: 30,
            )
          )
        ], 
        centerTitle: true,
        title: Text(
            "Kết quả",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Color(0xff105480),),
        )
      ),
      backgroundColor: Colors.white,
      //body show list item
      body:  SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
               SizedBox(height: 10,),
               //List view kết quả
               SizedBox(
                 width: myWidth,
                 height: heightDevice*0.72,
                 child: ListView.builder(
                     padding: const EdgeInsets.all(8),
                     itemCount: resultItem.length,
                     itemBuilder: (BuildContext context, int index) {
                       return Column(children: [
                         Container(
                            width: myWidth,
                            height: 100,
                            child: Row(children: [
                              //Ảnh sản phẩm
                              SizedBox(
                                height: 100,
                                width: myWidth*0.3,
                                child: Image.network(
                                   getUrlFromLinkImg("${resultItem[index].linkImg}")
                                ),
                              ),
                              SizedBox(width: 10,),
                              //Tên, xuất xứ và giá. SL: x1
                              SizedBox(
                                height: 100,
                                width: myWidth*0.6,
                                child: Column(
                                  children: [
                                    // tên sản phẩm
                                    SizedBox(
                                      height: 30,
                                      width: myWidth*0.6,
                                      child: Text(
                                        "${resultItem[index].name}", 
                                         maxLines: 1,
                                         overflow: TextOverflow.ellipsis,
                                         softWrap: false,
                                         textAlign: TextAlign.left,
                                         style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),                                        
                                      )
                                    ),
                                    // Danh mục
                                    SizedBox(
                                      height: 24,
                                      width: myWidth*0.6,
                                      child: Text(
                                         "Danh mục: " + "${resultItem[index].category?['name']}", 
                                         maxLines: 1,
                                         overflow: TextOverflow.ellipsis,
                                         softWrap: false,
                                         textAlign: TextAlign.left,
                                         style: TextStyle(fontSize: 12, ),                                        
                                      )
                                    ),   
                                    // Xuất xứ
                                    SizedBox(
                                      height: 24,
                                      width: myWidth*0.6,
                                      child: Text(
                                         "Xuất xứ: " + "${resultItem[index].countryProduce}", 
                                         maxLines: 1,
                                         overflow: TextOverflow.ellipsis,
                                         softWrap: false,
                                         textAlign: TextAlign.left,
                                         style: TextStyle(fontSize: 12, ),                                        
                                      )
                                    ),                                                                     
                                    // giá bán lẻ
                                    SizedBox(
                                      height: 20,
                                      width: myWidth*0.6,
                                      child: Text(
                                         "${resultItem[index].retailPrice.replaceAllMapped(reg, mathFunc)}" + "đ" + "         x1", 
                                         maxLines: 1,
                                         textAlign: TextAlign.left,
                                         style: TextStyle(fontSize: 16, color: Color(0xffb01313), fontWeight: FontWeight.w500),                                        
                                      )
                                    ),                                    
                                  ],
                                ),
                              )
                            ]),
                         ),
                         Divider(),
                       ]);
                     }
                 ),
                ),
               //Số lượng + Thành tiền
               SizedBox(
                 height: 50,
                 width: myWidth,
                 child: Column(
                   mainAxisSize: MainAxisSize.min,
                   children: [
                     SizedBox(height: 5,),
                     //Thành tiền
                     SizedBox(
                       height: 25,
                       width: myWidth*0.92,
                        child: Row(
                          children: [
                            SizedBox(
                              width: myWidth*0.52,
                              child: Text(
                                "Tổng số tiền",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xff7b2626),
                                ),
                              ),
                            ),
                            Center(
                              child: SizedBox(
                                width: myWidth*0.4,
                                child: Center(child: Text(
                                  "${sumOfOrder.toString().replaceAllMapped(reg, mathFunc)}"+"đ",
                                  style: TextStyle(
                                     fontSize: 20,
                                     fontWeight: FontWeight.w800,
                                     color: Color(0xff7b2626),
                                  ),                                
                                ),)
                              ),
                            )
                          ]
                        ),
                     ),
                     //số lượng sản phẩm
                     SizedBox(height: 5,),
                     SizedBox(
                       height: 15,
                       width: myWidth*0.92,
                        child: Row(
                          children: [
                            SizedBox(
                              width: myWidth*0.52,
                              child: Text(
                                "Số lượng sản phẩm",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xffb01313),
                                ),
                              ),
                            ),
                            Center(
                              child: SizedBox(
                                width: myWidth*0.4,
                                child: Center(child: Text(
                                  "${resultItem.length}",
                                  style: TextStyle(
                                     fontSize: 13,
                                     fontWeight: FontWeight.w800,
                                     color: Color(0xff7b01313),
                                  ),                                
                                ),)
                              ),
                            )
                          ]
                        ),
                     ),
                   ],
                 ),
               ),
            ]),
        ),
      ),
      //bottom bar
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
              height: 55,
              width: widthDevice,
              child: Column(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 mainAxisSize: MainAxisSize.min,
                 children: [
                    SizedBox(height: 7), 
                    SizedBox(
                       height: 40,
                       child: Row(children: [
                       SizedBox(width: widthDevice*0.05,),
                       //Outline button hủy Bỏ
                       SizedBox(
                          height: 40,
                          width: widthDevice*0.425,
                          child: OutlinedButton(
                             onPressed: (){
                                 Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                             },
                             child: Text("Hủy bỏ", style: TextStyle(color: Color(0xff4690ff), fontWeight: FontWeight.w700),),
                             style: OutlinedButton.styleFrom(
                                 side: BorderSide(color: Color(0xff4690ff)),
                             ),
                          )
                       ),
                       SizedBox(width: widthDevice*0.05),
                       //Button hoàn tất
                       SizedBox(
                           height: 40,
                           width: myWidth*0.45,
                           child: ElevatedButton(
                              onPressed: (){
         
                              },
                              style: ButtonStyle(
                                 elevation: MaterialStateProperty.all(0),
                              ), 
                              child: Text("Hoàn tất", style: TextStyle(fontWeight: FontWeight.w700),), 
                           ),
                        ),
                      ],),
                    ),
                    SizedBox(height: 7,)
                ],
              ),
      ),
    );
  }


  // Hàm scan barcode
    Future<void> scanBarcodeNormal() async {
        String barcodeScanResponse;
        // Platform messages may fail, so we use a try/catch PlatformException.
        try {
            barcodeScanResponse = await FlutterBarcodeScanner.scanBarcode(
                '#ff6666', 'Hủy bỏ', true, ScanMode.BARCODE);
        }
        on PlatformException {
            barcodeScanResponse = 'Có lỗi xảy ra ở thiết bị';
        }

        // If the widget was removed from the tree while the asynchronous platform
        // message was in flight, we want to discard the reply rather than calling
        // setState to update our non-existent appearance.
        if (!mounted) return;

        setState(() {
            _scanBarcode = barcodeScanResponse;
        });
  
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