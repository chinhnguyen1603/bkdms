import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:bkdms/screens/features_screens/member_screens/EnterCustomer.dart';
import 'package:bkdms/components/AppBarTransparent.dart';
import 'package:bkdms/models/Agency.dart';
import 'package:bkdms/screens/features_screens/member_screens/debt_screens/DebtScreen.dart';
import 'package:bkdms/screens/features_screens/member_screens/level_screens/ScreenLevel.dart';
import 'package:bkdms/services/LevelProvider.dart';

class Member extends StatefulWidget {

  @override
  State<Member> createState() => _MemberState();
}

class _MemberState extends State<Member> {
  static const blueText = Color(0xff105480);
  static const textColor = Color(0xff27214d);
 
  @override
  Widget build(BuildContext context) {
    double heightDevice = 100.h;// chiều cao thiết bị
    double myWidth = 90.w;
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
                       GestureDetector(
                         onTap: () async{
                            //show dialog chờ get level
                            await showDialog (
                              context: context,
                              builder: (context) =>
                                FutureProgressDialog(getLevelFuture()),
                            ); 
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ScreenLevel()));
                         },
                         child: SizedBox( 
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
                       ),
                      // Khách hàng
                       GestureDetector(
                         onTap: (){

                         },
                         child: SizedBox( 
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
                       ),
                       // Công nợ
                       GestureDetector(
                         onTap: (){
                           Navigator.push(context, MaterialPageRoute(builder: (context) => DebtScreen()));
                         },
                         child: SizedBox( 
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
              // chính sách bán sỉ
              SizedBox(
                child: TextButton(
                  onPressed: (){
                   showModalBottomSheet<void>(
                     backgroundColor: Colors.white,
                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
                     context: context,
                     builder: (BuildContext context) {
                       return Container(
                           height: heightDevice*0.6,
                           child: Column(
                             children: <Widget>[
                               SizedBox(width: 100.w , child: IconButton(
                                 icon: Icon(Icons.cancel_presentation, size: 18,),
                                 alignment: Alignment.centerRight,
                                 onPressed: (){Navigator.pop(context);},
                               ),),
                               SizedBox(width: 100.w, child:Text('Dưới đây là các chính sách bán sỉ của BKDMS', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xffde7325)),),),
                               SizedBox(width: 100.w, height: 5,),
                               //quy tắc phân phối 
                               SizedBox(width: myWidth, child: Text("1. Cam kết quy tắc phân phối", style: TextStyle(fontWeight: FontWeight.w600, color: textColor),),),
                               SizedBox(width: myWidth, child: Text("• Áp dụng phân phối hàng một cấp - tức là không phân phối cùng một sản phẩm cho đại lý của đại lý"),),
                               SizedBox(width: myWidth, child: Text("• Nếu có trường hợp tranh chấp xảy ra, thì cả ba bên sẽ ngồi lại bàn bạc sao cho hợp lý, cùng có lợi"),),
                               //phương thức kinh donah
                               SizedBox(width: 100.w, height: 5,),
                               SizedBox(width: myWidth, child: Text("2. Phương thức kinh doanh", style: TextStyle(fontWeight: FontWeight.w600, color: textColor),),),
                               SizedBox(width: myWidth, child: Text("• Giá sản phẩm bao gồm giá đại lý và giá bán lẻ tại thời điểm niêm yết, nếu có thay đổi giá thì BKDMS sẽ thông báo và gửi bảng báo giá mới trước ít nhất 15 ngày."),),
                               SizedBox(width: myWidth, child: Text("• Đại lý tự quyết định giá bán để phù hợp với vị thế. Tuy nhiên giá bán ra không được thấp hơn 10% so với giá bán lẻ đề nghị cùng thời điểm."),),
                               //Xử lý công nợ
                               SizedBox(width: 100.w, height: 5,),
                               SizedBox(width: myWidth, child: Text("3. Hỗ trợ về hàng hóa", style: TextStyle(fontWeight: FontWeight.w600, color: textColor),),),
                               SizedBox(width: myWidth, child: Text("• Trong vòng 07 (bảy) ngày kể từ giao hàng. Quý đại lý sẽ được đổi hàng mới nếu sản phẩm được xác định lỗi từ nhà sản xuất."),),
                               SizedBox(width: myWidth, child: Text("• Trong trường hợp hàng hóa, giá cả không đúng với thỏa thuận mua hàng, Quý đại lý có quyền trả lại hàng cho TGTN. Việc trả lại hàng được thực hiện trong vòng 1 tháng kể từ ngày đại lý xác nhận đã nhận đơn hàng."),),
      
                             ],
                           ),
                       );
                     },
                   );
                  }, 
                  child: Text(
                    "CHÍNH SÁCH BÁN SỈ",
                    style: TextStyle(decoration: TextDecoration.underline, fontSize: 21, color: blueText,),
                  )
                ),
              ),
              // tạo đơn bán lẻ
              SizedBox(
                child: TextButton(
                  onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => EnterCustomer()));
                  }, 
                  child: Text(
                    "TẠO ĐƠN BÁN LẺ",
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

  // hàm get order
  Future getLevelFuture() {
    return Future(() async {
      Agency user = Provider.of<Agency>(context, listen: false);
      await Provider.of<LevelProvider>(context, listen: false).getLevel(user.token, user.workspace)
     .catchError((onError) async {
          // Alert Dialog khi lỗi xảy ra
          print("Bắt lỗi future dialog delete all cart");
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
      });    
    });
  }      
 

}