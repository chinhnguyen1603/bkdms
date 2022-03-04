import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:bkdms/HomePage/HomePage.dart';
import 'dart:async';

class FeedBack extends StatefulWidget {

  @override
  State<StatefulWidget> createState(){
    return FeedBackState();
  }
}


class  FeedBackState extends State<FeedBack> {
  static const blueText = Color(0xff105480);
  late String _timeString;

  @override
  // hàm khởi tạo state
  void initState() {
    _timeString = _formatDateTime(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    super.initState();
  }
  
  // Build widget
  Widget build(BuildContext context) {
    double widthDevice = MediaQuery.of(context).size.width;
    double myWidth = widthDevice*0.9;  
    return Scaffold(
      backgroundColor: Colors.white,    
      appBar: AppBar(
        backgroundColor: Colors.white,  
        elevation: 0,   
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: blueText,
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
            }, 
            icon: Icon(
              Icons.home_filled,
              color: blueText,
            )
          )
        ],      
        centerTitle: true,
        title: Text(
          "Gửi phản hồi",
          style: TextStyle(
            fontSize: 20,
            color: blueText,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
         children:[
          SizedBox(height: 20,),
          SizedBox(
            child: Text(
              _timeString,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ),
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
                decoration: InputDecoration(
                  hintText: "Tiêu đề",
                  hintStyle: TextStyle(
                    color: Color(0xff7b2626),
                  ),
                  border: InputBorder.none,
              ),
            ),
           )
          )
          ),
         
          SizedBox(height: 15,),
          // Nội dung
          Container(
            width: myWidth,
            height: 200,
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
                decoration: InputDecoration(
                  hintText: "Nhập nội dung...",
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                  border: InputBorder.none,
              ),
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
                    onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      content: const Text(
                        'CẢM ƠN ĐÃ GỬI PHẢN HỒI. CHÚNG TÔI ĐÃ TIẾP NHẬN VÀ SẼ XỬ LÝ SỚM NHẤT CÓ THỂ',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                           fontSize: 14,
                           fontWeight: FontWeight.w300,
                        ),
                      ),
                      actions: [TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                            'OK',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),                      
                      ],                  
                    ),
                  ),
 
                       icon: Icon(
                         Icons.send,
                         color: Colors.white,
                       ))
                   ),)
          ]
        ),
      ),
    );
  }

  //2 hàm phụ trợ
  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _timeString = formattedDateTime;
    });
  }
  String _formatDateTime(DateTime dateTime) {
    return DateFormat('MM/dd/yyyy\n hh:mm:ss').format(dateTime);
  }
}