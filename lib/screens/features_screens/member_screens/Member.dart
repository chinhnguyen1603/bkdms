import 'package:flutter/material.dart';
import 'package:bkdms/screens/features_screens/member_screens/EnterCustomer.dart';
import 'package:bkdms/components/AppBarTransparent.dart';
class Member extends StatelessWidget {
  static const blueText = Color(0xff105480);
 
  @override
  Widget build(BuildContext context) {
    double heigtDevice = MediaQuery.of(context).size.height;// chiều cao thiết bị
    double widthDevice = MediaQuery.of(context).size.width;// chiều rộng thiết bị
    double myWidth = widthDevice*0.9;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarTransparent(Colors.white,"Thành viên"),
      body: Column(
        children: [
          SizedBox(height: 40,),
          //Vùng Congtainer chứa card thành viên
          Container(
            width: myWidth,
            height: 160,
            decoration: BoxDecoration(
              color:  Color(0xffF3F3F3),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                //2 text đầu
                SizedBox(
                  height: 50,
                  width: myWidth,
                  child: Row(
                    children: [
                      // text Hạng mức
                      SizedBox(
                        height: 50,
                        width: myWidth*0.33,
                        child: Center( child: Text(
                          "Cơ bản",
                          style: TextStyle(
                            color: Color(0xff544c4c),
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),),
                      SizedBox(width: myWidth*0.33,),
                      // Text Point
                      SizedBox(
                        height: 50,
                        width: myWidth*0.33,
                        child: Center( child: Text(
                          "250",
                          style: TextStyle(
                            color: Color(0xffcf0606),
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),),
                    ],
                  ),
                ),
                
                Divider( thickness: 1, height: 1,),
                //3 icon button 
                SizedBox(
                  height: 100,
                  child: Row(
                     children: [
                       //Hạn mức
                       SizedBox( 
                         height: 100,
                         width: myWidth*0.33,
                         child: Column(children: [
                           SizedBox(
                             height: 60,
                             width: myWidth*0.33,
                             child: Image.asset("assets/hangmuc.png", scale: 1.2, ),
                           ),
                           SizedBox(
                             height: 20,
                             width: myWidth*0.33,
                             child: Center(child: Text("Hạn mức")),
                           )
                         ],),
                       ),
                       // Khách hàng
                       SizedBox( 
                         height: 100,
                         width: myWidth*0.33,
                         child: Column(children: [
                           SizedBox(
                             height: 60,
                             width: myWidth*0.33,
                             child: Image.asset("assets/khachhang.png", scale: 1.1, ),
                           ),
                           SizedBox(
                             height: 20,
                             width: myWidth*0.33,
                             child: Center(child: Text("Khách hàng")),
                           )
                         ],),
                       ),
                       // Công nợ
                       SizedBox( 
                         height: 100,
                         width: myWidth*0.33,
                         child: Column(children: [
                           SizedBox(
                             height: 60,
                             width: myWidth*0.33,
                             child: Image.asset("assets/congno.png", scale: 1.3, ),
                           ),
                           SizedBox(
                             height: 20,
                             width: myWidth*0.33,
                             child: Center(child: Text("Công nợ")),
                           )
                         ],),
                       ),
                     ],
                   ),
                )
              ],
            ),
          ),

          // 3 dòng text Button
          Center(
            child: Column(children: [
              SizedBox(height: 120,),
              // Thể lệ thành viên
              SizedBox(
                child: TextButton(
                  onPressed: (){
                   showModalBottomSheet<void>(
                     backgroundColor: Colors.white,
                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
                     context: context,
                     builder: (BuildContext context) {
                       return Container(
                           height: heigtDevice*0.6,
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             mainAxisAlignment: MainAxisAlignment.start,
                             mainAxisSize: MainAxisSize.max,
                             children: <Widget>[
                               SizedBox(width: widthDevice,child: IconButton(
                                 icon: Icon(Icons.cancel_presentation, size: 20,),
                                 alignment: Alignment.centerRight,
                                 onPressed: (){Navigator.pop(context);},
                               ),),
                               SizedBox(width: widthDevice,child:Text('Thể lệ thành viên dành cho đại lý', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold),),),
                               SizedBox(height: 5,),
                               SizedBox(width: widthDevice, child: Text("   Có 4 cấp thành viên tương ứng là Cơ bản, Đồng, Bạc và Vàng."),),
                               //thành viên cơ bản, hạng mức 1
                               SizedBox(width: widthDevice, child: Text("  • Thành viên cơ bản", style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey),),),
                               SizedBox(width: widthDevice, child: Text("  Tương ứng với hạng mức 1. Thành viên cơ bản bắt buộc phải thanh toán trước khi nhận hàng."),),
                               //thành viên đồng, hạng mức 2
                               SizedBox(width: widthDevice, child: Text("  • Thành viên đồng", style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xffde7325)),),),
                               SizedBox(width: widthDevice, child: Text("  Tương ứng với hạng mức 2")),
                               //thành viên bạc, hạng mức 3
                               SizedBox(width: widthDevice, child: Text("  • Thành viên bạc", style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xffd8d2cf)),),),
                               SizedBox(width: widthDevice, child: Text("  Tương ứng với hạng mức 3")),
                               //thành viên vàng, hạng mức 4
                               SizedBox(width: widthDevice, child: Text("  • Thành viên vàng", style: TextStyle(fontWeight: FontWeight.w600, color: Colors.yellowAccent),),),  
                               SizedBox(width: widthDevice, child: Text("  Tương ứng với hạng mức 4")),
                             ],
                           ),
                       );
                     },
                   );
                  }, 
                  child: Text(
                    "THỂ LỆ THÀNH VIÊN",
                    style: TextStyle(decoration: TextDecoration.underline, fontSize: 21, color: blueText,),
                  )
                ),
              ),
              // tạo đơn bán hàng
              SizedBox(
                child: TextButton(
                  onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => EnterCustomer()));
                  }, 
                  child: Text(
                    "TẠO ĐƠN BÁN HÀNG",
                    style: TextStyle(decoration: TextDecoration.underline, fontSize: 21, color: blueText,),
                  )
                ),
              ),
              // lịch sử bán hàng
              SizedBox(
                child: TextButton(
                  onPressed: (){

                  }, 
                  child: Text(
                    "LỊCH SỬ BÁN HÀNG",
                    style: TextStyle(decoration: TextDecoration.underline, fontSize: 21, color: blueText,),
                  )
                ),
              )
   
            ],),
          ),
        ],
      ),
    );
  }
}