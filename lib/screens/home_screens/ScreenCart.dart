import 'package:bkdms/models/Cart.dart';
import 'package:flutter/material.dart';
import 'package:bkdms/screens/home_screens/HomePage.dart';
import 'package:bkdms/models/Agency.dart';
import 'package:bkdms/services/CartProvider.dart';
import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:provider/provider.dart';
import 'package:bkdms/models/CountBadge.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:bkdms/services/ProvinceProvider.dart';
import 'package:bkdms/screens/home_screens/TestProvince.dart';

class ScreenCart extends StatefulWidget {
  const ScreenCart({ Key? key }) : super(key: key);

  @override
  State<ScreenCart> createState() => ScreenCartState();
}


class ScreenCartState extends State<ScreenCart> {
  static const darkGrey = Color(0xff544C4C);
  //list cart
  List<Cart> lstCart = [];

  //form nhập số lượng sản phẩm
  final _formEnterAmountKey = GlobalKey<FormState>();
  final enternAmountController = TextEditingController();

  //tổng tiền 
  int sumOfOrder = 0;
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    lstCart = Provider.of<CartProvider>(context).lstCart;
    // tính tổng tiền của giỏ hàng
    for (var cart in lstCart){
      sumOfOrder = sumOfOrder + int.parse(cart.unit['agencyPrice'])*int.parse(cart.quantity);
    }
  }

  @override
  Widget build(BuildContext context) {
    double widthDevice = MediaQuery.of(context).size.width;// chiều rộng thiết bị
    double myWidth = widthDevice*0.9;
    //thêm dấu chấm vào giá sản phẩm
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    String Function(Match) mathFunc = (Match match) => '${match[1]}.';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: darkGrey,
          ),
          onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context), 
            icon: Icon(Icons.add_shopping_cart, color: darkGrey, size: 22,)
          )
        ],
        centerTitle: true,
        title: Text(
            "Giỏ hàng",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: darkGrey,
            ),
        )
      ), 
      backgroundColor: Color(0xffF0ECEC), // background color của màn hình
      body: SingleChildScrollView(
        child: Column(
          children: [
             // 3 icon đầu
             Container(
               width: widthDevice,
               color: Colors.white,
               height: 50,
               child: Row(children: [
                 SizedBox(
                  width: widthDevice*0.2,
                 ),
                 Container(
                   width: widthDevice*0.13,
                   height: 25,
                   decoration: new BoxDecoration(
                     shape: BoxShape.circle,
                     border: Border.all(color: Colors.grey)
                   ),
                   child: Icon(
                     Icons.shopping_cart,
                     size: 18,
                     color: darkGrey,
                   ),
                 ),
                 SizedBox(
                   width: widthDevice*0.1,
                   child: Text("-------------------", maxLines: 1, style: TextStyle(color: Color(0xff7b2626)),),
                 ),
                 Container(
                   width: widthDevice*0.13,
                   height: 25,
                   decoration: new BoxDecoration(
                     shape: BoxShape.circle,
                     border: Border.all(color: Colors.grey)
                   ),
                   child: Icon(
                     Icons.create_sharp ,
                     size: 18,
                     color: darkGrey, 
                   ),
                 ),
                 SizedBox(
                   width: widthDevice*0.1,
                   child: Text("----------------------", maxLines: 1, style: TextStyle(color: Color(0xff7b2626)),),
                 ),
                 Container(
                   width: widthDevice*0.13,
                   height: 25,
                   decoration: new BoxDecoration(
                     shape: BoxShape.circle,
                     border: Border.all(color: Colors.grey)
                   ),
                   child: Icon(
                     Icons.credit_card,
                     size: 18,
                     color: darkGrey, 
                   ),                   
                 ),
                


               ],)
             ),
             SizedBox(
               height: 10,
             ),
             
             //List view cart
             SizedBox(
               child: ListView.builder(
                     itemCount: lstCart.length,              
                     shrinkWrap: true,
                     physics: NeverScrollableScrollPhysics(),
                     itemBuilder: (BuildContext context, int index) {
                       return Column(
                         children: [
                           Container(
                             height: 140,
                             width: widthDevice,
                             color: Colors.white,
                             child: Center(
                               child: Row( children:[
                                 SizedBox(width: widthDevice*0.05),
                                 // ảnh sản phẩm
                                 SizedBox(
                                   child: Image.network(getUrlFromLinkImg(lstCart[index].unit['product']['linkImg']), width: widthDevice*0.3, height: 120,),
                                 ),
                                 //Tên + giá + đơn vị + số lượng
                                 SizedBox(
                                   width: widthDevice*0.62,
                                   height: 140,
                                   child: Column(children: [
                                     // icon button delete cart
                                     SizedBox(
                                       height: 30,
                                       width: widthDevice*0.62,
                                       child: IconButton(
                                          onPressed: (){
  
                                          }, 
                                          icon: Icon(Icons.cancel_presentation_sharp, size: 18,),
                                          alignment: Alignment.topRight,
                                     ),
                                     ),
                                     // tên sản phẩm + giá + đơn vị + số lượng
                                     SizedBox(
                                        height: 100,
                                        width: widthDevice*0.6,
                                        child: Column( children: [
                                          // tên
                                          SizedBox(
                                            height: 24,
                                            width: myWidth*0.6,
                                            child: Text(
                                               "${lstCart[index].unit['product']['name']}", 
                                               maxLines: 1,
                                               overflow: TextOverflow.ellipsis,
                                               softWrap: false,
                                               textAlign: TextAlign.left,
                                               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600 ),                                        
                                            )
                                          ), 
                                          // giá bán lẻ
                                          SizedBox(
                                            height: 24,
                                            width: myWidth*0.6,
                                            child: Text(
                                               "${lstCart[index].unit['agencyPrice'].replaceAllMapped(reg, mathFunc)}" + "đ", 
                                               maxLines: 1,
                                               textAlign: TextAlign.left,
                                               style: TextStyle(fontSize: 16, color: Color(0xffb01313), fontWeight: FontWeight.w500),                                        
                                            )
                                          ),     
                                          // Đơn vị
                                          SizedBox(
                                            height: 22,
                                            width: myWidth*0.6,
                                            child: Text(
                                               "Đơn vị: " + "${lstCart[index].unit['name']}", 
                                               textAlign: TextAlign.left,
                                               style: TextStyle(fontSize: 14, ),                                        
                                            )
                                          ),   
                                          // Số lượng + thay đổi số lượng
                                          SizedBox(
                                            height: 22,
                                            width: myWidth*0.6,
                                            child: Row(children: [
                                              SizedBox(
                                                height: 22,
                                                width: widthDevice*0.3,
                                                child: Text("Số lượng: " + "${lstCart[index].quantity}", textAlign: TextAlign.left, style: TextStyle(fontSize: 14, ),),
                                              ),
                                              //text button thay đổi số lượng
                                              SizedBox(
                                                height: 22,
                                                width: widthDevice*0.2,
                                                child: GestureDetector(
                                                  onTap: (){
                                                  showModalBottomSheet<void>(
                                                     isDismissible: false,
                                                     useRootNavigator: true,
                                                     backgroundColor: Colors.white,
                                                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft:  Radius.circular(10), topRight:  Radius.circular(10)),),
                                                     context: context,
                                                     builder: (BuildContext context) {
                                                       return StatefulBuilder( builder: (BuildContext context, setState) =>
                                                        Container(
                                                           height: 250,
                                                           child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              mainAxisSize: MainAxisSize.max,
                                                              children: <Widget>[
                                                                // icon button xóa 
                                                                SizedBox(
                                                                  width: widthDevice,
                                                                  height: 30,
                                                                  child: IconButton(
                                                                    icon: Icon(Icons.cancel_presentation, size: 20,),
                                                                    alignment: Alignment.centerRight,
                                                                    onPressed: () {
                                                                       Navigator.pop(context);
                                                                    },
                                                                  ),
 
                                                                ),
                                                                SizedBox(height: 5,),
                                                                
                                                                // ảnh sp + tên + giá + đơn vị
                                                                Container(
                                                                   width: myWidth,
                                                                   height: 80,
                                                                   child: Row(children: [
                                                                     SizedBox(width: 10,),
                                                                      //Ảnh sản phẩm
                                                                      SizedBox(
                                                                         height: 100,
                                                                         width: myWidth*0.3,
                                                                         child: Image.network(
                                                                             getUrlFromLinkImg("${lstCart[index].unit['product']['linkImg']}")
                                                                         ),
                                                                      ),
                                                                      SizedBox(width: 10,),
                                                                      //Tên, xuất xứ và giá
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
                                                                                       "${lstCart[index].unit['product']['name']}", 
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
                                                                                      "Đơn vị: " + "${lstCart[index].unit['name']}", 
                                                                                      maxLines: 1,
                                                                                      overflow: TextOverflow.ellipsis,
                                                                                      softWrap: false,
                                                                                      textAlign: TextAlign.left,
                                                                                      style: TextStyle(fontSize: 12, ),                                        
                                                                                    )
                                                                                ),                                                                     
                                                                                // giá bán cho đại lý
                                                                                SizedBox(
                                                                                    height: 20,
                                                                                    width: myWidth*0.6,
                                                                                    child: Text(
                                                                                      "${lstCart[index].unit['agencyPrice'].replaceAllMapped(reg, mathFunc)}" + "đ", 
                                                                                      maxLines: 1,
                                                                                      textAlign: TextAlign.left,
                                                                                      style: TextStyle(fontSize: 16, color: Color(0xffb01313), fontWeight: FontWeight.w500),                                        
                                                                                    )
                                                                                ),                                    
                                                                             ],),
                                                                      )
                                                                  ]),
                                                                ),
                                                                
                                                                Divider(),    
                                                                //Nhập số lượng
                                                                SizedBox(
                                                                  height: 30,
                                                                  width: widthDevice,
                                                                  child: Row(children: [
                                                                    SizedBox(width: widthDevice*0.1,),
                                                                    // text nhập số lượng
                                                                    SizedBox(
                                                                      width: myWidth*0.6,
                                                                      height: 30,
                                                                      child: Column(
                                                                        children: [
                                                                          SizedBox(height: 8,),
                                                                          SizedBox(height: 20,width: myWidth*0.6, child: Text("Nhập số lượng", textAlign: TextAlign.left,style: TextStyle(color: darkGrey, fontSize: 14),),),
                                                                          SizedBox(height: 2,),
                                                                        ],
                                                                      )
                                                          
                                                                    ),
                                                                    //text formfield điền số lượng hàng
                                                                    SizedBox(
                                                                      height: 30,
                                                                      width: 60, 
                                                                      child: Form(
                                                                        key: _formEnterAmountKey,
                                                                        child: TextFormField(
                                                                          controller: enternAmountController,        
                                                                          keyboardType: TextInputType.number,
                                                                          cursorHeight: 14,
                                                                          textAlignVertical: TextAlignVertical.center,
                                                                          style: TextStyle(fontSize: 14),
                                                                          validator: (value) {
                                                                             if (value == null || value.isEmpty) {
                                                                                return "trống";
                                                                             }
                                                                             return null;
                                                                          },  
                                                                          decoration:  InputDecoration(
                                                                             enabledBorder:  OutlineInputBorder(
                                                                                borderRadius: BorderRadius.circular(0),
                                                                                borderSide: BorderSide(color: darkGrey),
                                                                             ),
                                                                          )
                                                                        ),
                                                                      ),
                                                                   )
                                                                  ])
                                                                ),
                                                                Divider(),
                                                                //button cập nhật số lượng
                                                                SizedBox(height: 5,),
                                                                SizedBox(
                                                                  height: 45,
                                                                  width: widthDevice,
                                                                  child: Row(children: [
                                                                    SizedBox(width: widthDevice*0.1,),
                                                                    Container(
                                                                      height: 45,
                                                                      width: widthDevice*0.8,
                                                                      child: ElevatedButton(
                                                                        
                                                                        onPressed: () async {
                                                                          setState(() {              
                                                                              sumOfOrder = 0; //set tổng tiền về 0
                                                                          });
                                                                          //post api add cart tại đây
                                                                           if (_formEnterAmountKey.currentState!.validate()){
                                                                              await showDialog (
                                                                                 context: context,
                                                                                 builder: (context) =>
                                                                                    FutureProgressDialog(getFuture(lstCart[index].unitId), message: Text('Đang cập nhật...', style: TextStyle(color:Color(0xffe2dddd)))),
                                                                              );
                                                                              Navigator.pop(context);
                                                                           }
                                                                        },
                                                                        child: Text("Cập nhật", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                                                                        style: ButtonStyle(
                                                                            elevation: MaterialStateProperty.all(0),
                                                                            backgroundColor:  MaterialStateProperty.all<Color>(Color(0xff4690FF)),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ]),
                                                                )

                                                             ],
                                                           ),
                                                        ) );
                                                      },//builder
                                                  );//showmodal bottom sheet
 
                                                  }, 
                                                  child: Text("Thay đổi", textAlign: TextAlign.left, style: TextStyle(fontSize: 14, color: Colors.blueAccent),),
                                                )
                                              )
                                              
                                            ])
                                          ),                                                                                                    
                                        ],),
                                     )  
                                   ])
                                 )
                                ])
                             ),
                           ),
                           SizedBox(height: 10,),
                         ]
                       );
                     }
               )
             ),

             //áp dụng khuyến mãi
             Container(
               width: widthDevice,
               height: 80,
               color: Colors.white,
               child: SizedBox(
                  width: myWidth,
                  child: Column(
                    children: [
                      SizedBox(height: 5,),
                      //text khuyến mãi
                      SizedBox(
                        width: myWidth,
                        height: 20,
                        child: Text("Khuyến mãi", textAlign: TextAlign.left, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                      ),
                      SizedBox(height: 5,),
                      //formfield điền mã km
                      SizedBox(
                        width: myWidth,
                        height: 35,
                        child: Row(
                          children: [
                            SizedBox(
                              width: myWidth*0.65,
                              child:  TextFormField(
                                 keyboardType: TextInputType.text,
                                 cursorHeight: 24,
                                 textAlignVertical: TextAlignVertical.bottom,
                                 style: TextStyle(fontSize: 16, ),
                                 decoration:  InputDecoration(
                                    hintText: "Nhập mã",
                                    prefixIcon: Icon(Icons.discount_outlined),
                                    enabledBorder:  OutlineInputBorder(
                                       borderRadius: BorderRadius.circular(5),
                                      borderSide: BorderSide(color: Color(0xff544c4c)),
                                    ),
                                 ), 
                              ), 
                            ),
                            SizedBox(width: myWidth*0.1,),
                            SizedBox(
                              width: myWidth*0.25,
                              child: ElevatedButton(
                              onPressed: (){}, 
                              child: Text("Áp dụng"),
                                 style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(0),
                                    backgroundColor:  MaterialStateProperty.all<Color>(Color(0xff105480)),
                                 ),                             
                            )
                            )
                          ],
                        ),
                      )
                    ],
                  ),
               ),
             )
          ],
        ),
      ),
      //bottom button chọn mua
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
                          width: widthDevice*0.9,
                          height: 24,
                          child: Row(children: [
                            //text thành tiền
                            SizedBox(
                              width: widthDevice*0.3,
                              height: 24,
                              child: Center(
                                child: SizedBox(
                                  width: widthDevice*0.3,
                                  child: Text("Thành tiền", style: TextStyle(color: darkGrey, fontSize: 14))
                                )
                              )
                            ),
                            //Tổng giá tiền
                            SizedBox(
                              width: widthDevice*0.6,
                              height: 24,
                              child: Text(
                                "${sumOfOrder.toString().replaceAllMapped(reg, mathFunc)}" + "đ", 
                                maxLines: 1,
                                textAlign: TextAlign.right,
                                style: TextStyle(fontSize: 20, color: Color(0xffb01313), fontWeight: FontWeight.w500),                                        
                              )                              
                            )
                          ]),
                        ),
                        SizedBox(height: 7,),
                        SizedBox(
                          width: widthDevice*0.9,
                          height: 40,
                          //button tiến hành đặt hàng
                          child: ElevatedButton(
                              onPressed: () async {
                                  await Provider.of<ProvinceProvider>(context, listen: false).getProvince();
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => TestProvince()));
                              },
                              style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0),
                                  backgroundColor: MaterialStateProperty.all < Color > (Color(0xff4690FF)),
                                  shape: MaterialStateProperty.all < RoundedRectangleBorder > (
                                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0), )
                                  )
                              ),
                              child: Text("Tiến hành đặt hàng", style: TextStyle(fontWeight: FontWeight.w700), )
                          )  
                        ),
                        SizedBox(height: 7,),
                      ])
              )          
    );
  }
  // hàm lấy ảnh từ cloudinary 
  String getUrlFromLinkImg(String linkImg) {
        //linkImg receive from server as Public Id
        final cloudinaryImage = CloudinaryImage.fromPublicId("di6dsngnr", linkImg);
        String transformedUrl = cloudinaryImage.transform().width(256).thumb().generate() !;
        return transformedUrl;
  }   

  // hàm add cart rồi get, update số lượng sản phẩm
  Future getFuture(int unitId) {
    return Future(() async {
      Agency user = Provider.of<Agency>(context, listen: false);
      await Provider.of<CartProvider>(context, listen: false).addCart(user.token, user.workspace, user.id, unitId, enternAmountController.text)
     .catchError((onError) async {
          // Alert Dialog khi lỗi xảy ra
          print("Bắt lỗi future dialog");
          await showDialog(
              context: context, 
              builder: (ctx1) => AlertDialog(
                  title: Text("Oops! Có lỗi xảy ra", style: TextStyle(fontSize: 24),),
                  content: Text("$onError"),
                  actions: [TextButton(
                      onPressed: () => Navigator.pop(ctx1),
                      child: Center (child: const Text('OK', style: TextStyle(decoration: TextDecoration.underline,),),)
                  ),                      
                  ],                                      
              ));    
            throw onError;          
      })
      .then((value) async {
          //get cart và update CountBadge
          await Provider.of<CartProvider>(context, listen: false).getCart(user.token, user.workspace, user.id);
          Provider.of<CountBadge>(context, listen: false).setCounter(Provider.of<CartProvider>(context, listen: false).lstCart.length);   
      });    
    });
  }      


}