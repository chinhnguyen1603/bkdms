import 'package:flutter/material.dart';
import 'package:bkdms/components/AppBarTransparent.dart';
class Member extends StatelessWidget {
  static const blueText = Color(0xff105480);
 
  @override
  Widget build(BuildContext context) {
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
                       //Hạng mức
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
                             child: Center(child: Text("Hạng mức")),
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
                     context: context,
                     builder: (BuildContext context) {
                       return Container(
                         height: 400,
                         color: Colors.white,
                           child: Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                             mainAxisSize: MainAxisSize.min,
                             children: <Widget>[
                               Text('Thể lệ thành viên'),
                               ElevatedButton(
                                 child: const Text('Close BottomSheet'),
                                 onPressed: () => Navigator.pop(context),
                               )
                             ],
                           ),
                       );
                     },
                   );
                  }, 
                  child: Text(
                    "THỂ LỆ THÀNH VIÊN",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 21,
                      color: blueText,
                    ),
                  )
                ),
              ),
              // tạo đơn bán hàng
              SizedBox(
                child: TextButton(
                  onPressed: (){

                  }, 
                  child: Text(
                    "TẠO ĐƠN BÁN HÀNG",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 21,
                      color: blueText,
                    ),
                  )
                ),
              ),
              // lịch sử tích điểm
              SizedBox(
                child: TextButton(
                  onPressed: (){

                  }, 
                  child: Text(
                    "LỊCH SỬ TÍCH ĐIỂM",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 21,
                      color: blueText,
                    ),
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