import 'dart:async';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:sizer/sizer.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:bkdms/models/Item.dart';
import 'package:bkdms/services/ItemProvider.dart';
import 'package:bkdms/screens/home_screens/homepage_screens/HomePage.dart';
import 'package:bkdms/models/Agency.dart';
import 'package:bkdms/models/CartBarcode.dart';
import 'package:bkdms/screens/features_screens/member_screens/SuccessSale.dart';
import 'package:bkdms/services/ConsumerProvider.dart';

class ResultBarcode extends StatefulWidget {
  late Item receiveItem;
  late var receiveUnit;
  late String receviveAmount;
  ResultBarcode(this.receiveItem, this.receiveUnit, this.receviveAmount);

  @override
  State<ResultBarcode> createState() => _ResultBarcodeState();
}




class _ResultBarcodeState extends State<ResultBarcode> {
  List<CartBarcode> resultCart = [];
  String _scanBarcode = '';
  bool isShowDialog = true;
  int needShowDialog = 1;
  // tổng tiền
  int sumOfOrder = 0;

  // form nhập số lượng
  final amountController = TextEditingController();  
  final _formAmountKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    //khởi tạo các list từ item đc scan ở widget trước
    resultCart.add(CartBarcode(linkImg: widget.receiveItem.linkImg, name: widget.receiveItem.name, unitName: widget.receiveUnit['name'], quantity: int.parse(widget.receviveAmount), unitId: widget.receiveUnit['id'], price: widget.receiveUnit['retailPrice']));
    // tổng tiền của đơn hàng
    sumOfOrder = int.parse(widget.receiveUnit['retailPrice'])*int.parse(widget.receviveAmount);
  }

  @override
  Widget build(BuildContext context) {
    double widthDevice = 100.w;// chiều rộng thiết bị
    double heightDevice = 100.h;// chiều cao thiết bị
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
              //lấy biến số lượng
              String amount ="";
              await scanBarcodeNormal();
              for (var item in Provider.of<ItemProvider>(context, listen: false).lstItem){
                  for(var unit in item.units){
                    //nếu trùng barcode trong unit thì xử lý
                    if(_scanBarcode == unit['barcode']){
                      //thông báo nhập số lượng cho sản phẩm đó
                      await Alert(
                        context: context,
                        type: AlertType.none,
                        desc: "Nhập số lượng",
                        content: Form(
                          key: _formAmountKey,
                            child: TextFormField(
                              controller: amountController,
                              keyboardType: TextInputType.number,
                              cursorHeight: 20,
                              cursorColor: Colors.black,
                              textAlignVertical: TextAlignVertical.center,
                              style: TextStyle(fontSize: 18),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "trống";
                                }
                                return null;
                              },                
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.exposure_sharp ,size: 26,),
                              ),
                            ),
                        ),
                        buttons: [ 
                          DialogButton(
                            width: 100,
                            child: Text("OK", style: TextStyle(color: Colors.white, fontSize: 20),),
                            onPressed: () {
                              // check form có null không
                              if (_formAmountKey.currentState!.validate()){
                                setState(() {
                                  amount = amountController.text;
                                });
                                Navigator.pop(context);
                              }
                            },         
                          )
                        ],
                      ).show();    

                      //set State showdialog và tổng tiền                         
                      setState(() {
                        needShowDialog = 0;
                        sumOfOrder = sumOfOrder + int.parse(unit['retailPrice'])*int.parse(amount);
                        print(sumOfOrder);
                      });
                      //tạo list cart để post đơn bán ra

                      bool needAddCart = false;
                      for(int index =0; index < resultCart.length; index++){
                        if(resultCart[index].unitId == unit['id']){
                          resultCart[index].quantity += int.parse(amount);
                          needAddCart = false;
                          break;
                        } 
                        needAddCart = true;
                      }
                      if(needAddCart == true){
                        resultCart.add(CartBarcode(linkImg: item.linkImg, name: item.name, unitName: unit['name'], quantity: int.parse(amount), unitId: unit['id'], price: unit['retailPrice']));
                      }
                      break;
                    } 
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
                     itemCount: resultCart.length,
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
                                   getUrlFromLinkImg("${resultCart[index].linkImg}")
                                ),
                              ),
                              SizedBox(width: 10,),
                              //Tên sp, tên đơn vị, đơn giá + số lượng
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
                                        "${resultCart[index].name}", 
                                         maxLines: 1,
                                         overflow: TextOverflow.ellipsis,
                                         softWrap: false,
                                         textAlign: TextAlign.left,
                                         style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),                                        
                                      )
                                    ),
                                    // Đơn vị
                                    SizedBox(
                                      height: 24,
                                      width: myWidth*0.6,
                                      child: Text(
                                         "Đơn vị: " + "${resultCart[index].unitName}", 
                                         maxLines: 1,
                                         overflow: TextOverflow.ellipsis,
                                         softWrap: false,
                                         textAlign: TextAlign.left,
                                         style: TextStyle(fontSize: 14, ),                                        
                                      )
                                    ),   
                                    // giá bán lẻ
                                    SizedBox(
                                      height: 20,
                                      width: myWidth*0.6,
                                      child: Row(
                                        children: [
                                          //đơn giá
                                          SizedBox(
                                            width: myWidth*0.6*0.6,
                                            child: Text(
                                               "${resultCart[index].price.replaceAllMapped(reg, mathFunc)}", 
                                               maxLines: 1,
                                               textAlign: TextAlign.left,
                                               style: TextStyle(fontSize: 17, color: Color(0xffb01313), fontWeight: FontWeight.w500),                                        
                                            ),
                                          ),
                                          //số lượng sp
                                          Text(
                                            "x${resultCart[index].quantity}", 
                                            maxLines: 1,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(fontSize: 17, color: Color(0xffb01313), fontWeight: FontWeight.w500),                                        
                                          ),                                          
                                        ],
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
                                  "${resultCart.length}",
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
                                 Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(0)));
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
                              onPressed: () async {
                                //tạo list product để post
                                print(resultCart); 
                                Provider.of<ConsumerProvider>(context, listen: false).setListProduct(resultCart);  
                                //show dialog chờ tạo đơn bán lẻ
                                await showDialog(
                                  context: context,
                                  builder: (context) =>
                                    FutureProgressDialog(createSaleOrder().then((_) => Navigator.push(context, MaterialPageRoute(builder: (context) => SuccessSale())))),
                                );
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
      //linkImg receive from server as Public Id
      final cloudinaryImage = CloudinaryImage.fromPublicId("di6dsngnr", linkImg);
      String transformedUrl = cloudinaryImage.transform().width(256).thumb().generate()!;
      return transformedUrl;
  }

  // hàm post đơn bán lẻ
  Future createSaleOrder() {
    return Future(() async {
      Agency user = Provider.of<Agency>(context, listen: false);
      await Provider.of<ConsumerProvider>(context, listen: false).createSale(user.token, user.workspace, user.id)
        .catchError((onError) async {
          // phụ trợ xử lí String
          String fault = onError.toString().replaceAll("{", ""); // remove {
          String outputError = fault.replaceAll("}", ""); //remove }  
          // Alert Dialog khi lỗi xảy ra
          print("Bắt lỗi future dialog create Sale");
          await showDialog(
              context: context, 
              builder: (ctx) => AlertDialog(
                  title: Text("Oops! Có lỗi xảy ra", style: TextStyle(fontSize: 24),),
                  content: Text("$outputError"),
                  actions: [TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: Center (child: const Text('OK', style: TextStyle(decoration: TextDecoration.underline,),),)
                  ),                      
                  ],                                      
              ));  
          //throw onerror ở đây để then trên showdialog ko bắt được
          throw onError;        
        });   
    });
  }      
  

}