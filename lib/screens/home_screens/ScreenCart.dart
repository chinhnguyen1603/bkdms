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
   


}