import 'package:flutter/material.dart';
import 'package:bkdms/components/AppBarTransWithHome.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class FeedBack extends StatefulWidget {

  @override
  State<StatefulWidget> createState(){
    return FeedBackState();
  }
}


class  FeedBackState extends State<FeedBack> {
  static const blueText = Color(0xff105480);  
  var darkGrey = Color(0xff544C4C); // màu xám
  //key form
  final _formFeedBackKey = GlobalKey<FormState>();
  //biến text input
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    double widthDevice = MediaQuery.of(context).size.width;
    double myWidth = widthDevice*0.9;  
    return Scaffold(
      backgroundColor: Colors.white,    
      appBar: AppBarTransparentWithHome(Colors.white,"Gửi phản hồi"),
      body: Form(
        key: _formFeedBackKey,
        child: Center(
          child: Column(
           children:[
            SizedBox(height: 30,),
            SizedBox(height: 10,),
            // Tiêu đề
            Container(
              width: myWidth,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 4,
                    offset: Offset(0,2),
                  )
                ],
              ),
              child: Center( child: SizedBox(
                width: myWidth*0.9,
                child: TextFormField(    
                  controller: titleController,  
                  style: TextStyle(color: Color(0xff7b2626),),
                  decoration: InputDecoration(
                    hintText: "Tiêu đề",
                    hintStyle: TextStyle(color: Color(0xff7b2626),),
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "trống";
                    }
                    return null;
                  },  
                ),
              )
              )
            ),
           
            SizedBox(height: 15,),
            // Nội dung
            Container(
              width: myWidth,
              height: 250,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 10,
                    offset: Offset(0, 0),
                  )
                ],
              ),
              child: Column( children:[ SizedBox(
                height: 150,
                width: myWidth*0.9,
                child: TextFormField(
                  controller: contentController,
                  maxLines: 7,
                  decoration: InputDecoration(
                    hintText: "Nhập nội dung...",
                    hintStyle: TextStyle(
                      color: Colors.black,
                    ),
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "trống";
                    }
                    return null;
                  },
                ),
              )
              ])
            ),  
          
            SizedBox(height: 40,),
            //Icon button gửi
            Container(
                    width: 45,
                    height: 45,
                    decoration: new BoxDecoration(
                       color: Colors.blueAccent,
                       shape: BoxShape.circle,
                       boxShadow: [
                         BoxShadow(
                           color: Colors.grey.withOpacity(0.6),
                           blurRadius: 10,
                           offset: Offset(0,1),
                           )
                       ],
                    ),
                    child: Center(
                       child: IconButton(
                       onPressed: () {
                        if (_formFeedBackKey.currentState!.validate()){
                          Alert(
                             context: context,
                             type: AlertType.success,
                             style: AlertStyle(
                               descTextAlign: TextAlign.start,
                               descStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w300, color: darkGrey),
                             ),
                             desc: "Cảm ơn đã gửi thông tin. Chúng tôi sẽ phản hồi trong thời gian sớm nhất",                
                             buttons: [ 
                               DialogButton(
                                child: Text("OK", style: TextStyle(color: Colors.white, fontSize: 20),),
                                onPressed: () => Navigator.pop(context),
                                width: 100,
                               )
                             ],
                           ).show();
                        }
                       },
                       icon: Icon(
                          Icons.send,
                          color: Colors.white,
                         )
                      )
                     ),)
            ]
          ),
        ),
      ),
    );
  }
}
  //2 hàm phụ trợ
/*  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _timeString = formattedDateTime;
    });
  }
  String _formatDateTime(DateTime dateTime) {
    return DateFormat('hh:mm a').format(dateTime);
  }
}*/