import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PolicyDebt extends StatelessWidget {
  double heightDevice = 100.h;// chiều cao thiết bị
  double myWidth = 90.w;
  static const blueText = Color(0xff105480);
  static const textColor = Color(0xff7b2626);  
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:  AppBar(
           elevation: 0,
           backgroundColor: Colors.white,
           leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Color(0xff105480),
              ),
              onPressed: (){
                Navigator.pop(context);
              },
           ),
        ),

      //body
      body: SingleChildScrollView(
                       child: Container(
                           height: heightDevice*0.8,
                           child: Column(
                             children: <Widget>[
                               SizedBox(width: 100.w , height: 1,),
                               SizedBox(width: 100.w, child:Text('Dưới đây chính sách công nợ của BKDMS', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xffde7325), fontSize: 16),),),
                               SizedBox(width: 100.w, height: 8,),
                               //Định nghĩa
                               SizedBox(width: myWidth, child: Text("1. Định nghĩa", style: TextStyle(fontWeight: FontWeight.w600, color: textColor),),),
                               SizedBox(width: 100.w, height: 3,),
                               SizedBox(width: myWidth, child: Text("• Công nợ là số tiền đại lý nợ khi đặt đơn hàng với hình thức thanh toán nợ. Mỗi đại lý có hạn mức nợ tối đa tương ứng cấp thành viên của mình. Xem thêm trong mục \'Hạn mức\'."),),
                               SizedBox(width: 100.w, height: 3,),
                               SizedBox(width: myWidth, child: Text("• Cuối mỗi tháng, chúng tôi sẽ làm đối chiếu công nợ những đơn hàng phát sinh trong tháng và thông tin đến cho đại lý qua các hình thức (email, điện thoại ...). để cùng đối chiếu và xác nhận. "),),
                               //phương thức kinh donah
                               SizedBox(width: 100.w, height: 8,),
                               SizedBox(width: myWidth, child: Text("2. Phương thức trả nợ", style: TextStyle(fontWeight: FontWeight.w600, color: textColor),),),
                               SizedBox(width: 100.w, height: 3,),
                               SizedBox(width: myWidth, child: Text("• Có 3 phương thức bao gồm trả tiền mặt, chuyển khoản ngân hàng và thanh toán qua ví điện tử Momo. Hạn thanh toán từ ngày 1 đến ngày 5 hàng tháng."),),
                               SizedBox(width: 100.w, height: 3,),
                               SizedBox(width: myWidth, child: Text("• Số tiền trả nợ mỗi lần không thấp hơn 10% tổng nợ hiện tại. Chúng tôi khuyến khích sử dụng phương thức thanh toán qua ví điện tử."),),
                               //Xử lý thanh toán chậm
                               SizedBox(width: 100.w, height: 8,),
                               SizedBox(width: myWidth, child: Text("3. Xử lý thanh toán chậm", style: TextStyle(fontWeight: FontWeight.w600, color: textColor),),),
                               SizedBox(width: 100.w, height: 3,),
                               SizedBox(width: myWidth, child: Text("•  Đến hạn thanh toán mà đại lý vẫn chưa thanh toán đủ công nợ phát sinh của tháng trước thì sẽ bị tính lãi xuất phát sinh. % lãi xuất tính theo ngân hàng VCB tại cùng thời điểm"),),
                               SizedBox(width: 100.w, height: 3,),
                               SizedBox(width: myWidth, child: Text("• Nếu đến đối chiếu công nợ lần 2 mà đại lý vẫn chưa thanh toán hết nợ thì BKDMS sẽ tạm ngưng giao đơn hàng mới."),),
      
                             ],
                           ),
                       )
 
      ),
    );
  }
}