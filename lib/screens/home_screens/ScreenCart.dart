import 'package:bkdms/models/Cart.dart';
import 'package:flutter/material.dart';
import 'package:bkdms/screens/home_screens/HomePage.dart';
import 'package:bkdms/models/Agency.dart';
import 'package:bkdms/services/CartProvider.dart';
import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:provider/provider.dart';
import 'package:bkdms/models/CountBadge.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';

class ScreenCart extends StatefulWidget {
  const ScreenCart({ Key? key }) : super(key: key);

  @override
  State<ScreenCart> createState() => ScreenCartState();
}


class ScreenCartState extends State<ScreenCart> {
  static const darkGrey = Color(0xff544C4C);
  //list cart
  List<Cart> lstCart = [];

  //id của đơn vị
  int unitId = 0;
  //form nhập số lượng sản phẩm
  final _formEnterAmountKey = GlobalKey<FormState>();
  final enternAmountController = TextEditingController();
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    lstCart = Provider.of<CartProvider>(context).lstCart;
  }

  @override
  Widget build(BuildContext context) {
    double widthDevice = MediaQuery.of(context).size.width;// chiều rộng thiết bị
    double myWidth = widthDevice*0.9;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: darkGrey,),
          onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
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
                     itemCount: 3,              
                     shrinkWrap: true,
                     physics: NeverScrollableScrollPhysics(),
                     itemBuilder: (BuildContext context, int index) {
                       return Column(
                         children: [
                           Container(
                             height: 140,
                             color: Colors.white,
                           ),
                           SizedBox(height: 10,)
                         ],
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
  Future getFuture() {
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