import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:bkdms/Features_Screen/FeedBack.dart';
import 'package:bkdms/Components/AppBarTransparent';


class TextGrey extends StatelessWidget {
  static const greyText = Color(0xff544c4c);
  final String input;
  TextGrey(this.input);

  @override
  Widget build(BuildContext context) {
    return Text(
      "$input",
      textAlign: TextAlign.left,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: greyText,
      ),
    );
  }
}

class Contact extends StatefulWidget {

  State<StatefulWidget> createState(){
    return ContactState();
  }
}


class ContactState extends State<Contact> {
  static const greyBackground = Color(0xfffafafa);
  static const blueText = Color(0xff105480);


  @override
  Widget build(BuildContext context) {
    double widthDevice = MediaQuery.of(context).size.width;
    double myWidth = widthDevice*0.9;
    
    return Scaffold(
      backgroundColor: greyBackground,
     /* appBar: AppBar(
        elevation: 0,
        backgroundColor: greyBackground,       
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: blueText,
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),     
        centerTitle: true,
        title: Text(
          "Liên hệ",
          style: TextStyle(
            fontSize: 22,
            color: blueText,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),*/
      appBar: AppBarTransparent(greyBackground,"Liên hệ"),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
          children: [
          SizedBox(height: 10,),
         
          //text thông tin liên lạc
          SizedBox(
            width: myWidth,
            height: 25,
            child: TextGrey("Thông tin liên lạc"),       
          ),
          // container thông tin liên lạc
          Container(
            width: myWidth,
            height: 140,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 3,
                  offset: Offset(0, 2),
                )
              ],
            ),
            child: Column(children: [
              SizedBox(height: 5,),
              // Facebook    
              SizedBox(
                width: myWidth,
                height: 30,
                child: Row(children: [
                  SizedBox(//icon Facbook
                    width: myWidth*0.12,
                    child: Icon(
                      Icons.facebook_rounded,
                      color: Color(0xff254fb0),
                    ),
                  ),
                  SizedBox(
                    width: myWidth*0.8,
                    child: Text(
                      "https://www.facebook.com/BachKhoaDMS"
                    ),
                  )
                ],),
              ),
              
              // Gmail
              SizedBox(
                width: myWidth,
                height: 30,
                child: Row(children: [
                  SizedBox(//icon FGmail
                    width: myWidth*0.12,
                    child: Icon(
                      Icons.email_outlined,
                      color: Color(0xffb01313),
                    ),
                  ),
                  SizedBox(
                    width: myWidth*0.8,
                    child: Text(
                      "support@bkdms.vn"
                    ),
                  )
                ],),
              ),

              //Phone
              SizedBox(
                width: myWidth,
                height: 30,
                child: Row(children: [
                  SizedBox(//icon Phone
                    width: myWidth*0.12,
                    child: Icon(
                      Icons.phone_in_talk,
                      color: Color(0xff4bad3a),
                    ),
                  ),
                  SizedBox(
                    width: myWidth*0.8,
                    child: Text(
                      "0898125108 - 0987438140"
                    ),
                  )
                ],),
              ),
              
              // Địa chỉ BKDMS
              SizedBox(
                width: myWidth,
                height: 32,
                child: Row(children: [
                  SizedBox(//icon Phone
                    width: myWidth*0.12,
                    child: Icon(
                      Icons.map_sharp,
                      color: Color(0xffba5b47),
                    ),
                  ),
                  SizedBox(
                    width: myWidth*0.8,
                    child: Text(
                      "Khu công nghệ phần mềm ĐHQG, khu phố 6, phường Linh Trung, Thủ Đức, TPHCM"
                    ),
                  )
                ],),
              ),
            ],),
          ),
          
          SizedBox(height: 35,),
          //Text phản hồi trực tiếp
          SizedBox(
            width: myWidth,
            height: 25,
            child: TextGrey("Phản hồi trực tiếp"),       
          ),
          //Container phản hồi trực tiếp
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => FeedBack()));
            },
            child: Container(
            width: myWidth,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 3,
                  offset: Offset(0, 2),
                )
              ],
            ),
            child: Image.asset("assets/IconChat.png", scale: 1.1, ),
            ),
          ),

          SizedBox(height: 35,),
          //Text câu hỏi thường gặp
          SizedBox(
            width: myWidth,
            height: 25,
            child: TextGrey("Câu hỏi thường gặp"),       
          ),

          //câu hỏi 1
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: widthDevice*0.05,),
            child: 
              ExpansionTileCard(
                baseColor: Colors.white,
                initialElevation: 3,
                leading: Container(
                   width: 25,
                   height: 25,
                   decoration: new BoxDecoration(
                     color: Colors.white,
                     shape: BoxShape.circle,
                     boxShadow: [
                       BoxShadow(
                         color: Colors.grey.withOpacity(0.8),
                         blurRadius: 10,
                         )
                     ],
                   ),
                   child: Center(
                     child: Text("1",textAlign: TextAlign.center,style: TextStyle(fontWeight:FontWeight.bold,color: Colors.grey),)
                   ),
                ),
                title: Text(
                  "Về chúng tôi",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                children: <Widget>[
                  Divider(
                    thickness: 1.0,
                    height: 1.0,
                    indent: 10,
                    endIndent: 10,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5,bottom: 5),
                    width: myWidth*0.9,
                    child: Text(
                    "Ra đời vào năm 2022 bởi những sinh viên Bách Khoa. BKDMS là một hệ thống phần mềm quản lý phân phối sản phẩm ưu việt nhất hiện nay. Chúng tôi áp dụng công nghệ tiên tiến nhất cho doanh nghiệp và các đại lý.",
                    style: TextStyle(
                      color: Color(0xff4f5665),
                    ),
                  )),
                ]
              )
            ),
          
          //câu hỏi 2
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: widthDevice*0.05, vertical: 10,),
            child: 
              ExpansionTileCard(
                baseColor: Colors.white,
                initialElevation: 3,
                leading: Container(
                   width: 25,
                   height: 25,
                   decoration: new BoxDecoration(
                     color: Colors.white,
                     shape: BoxShape.circle,
                     boxShadow: [
                       BoxShadow(
                         color: Colors.grey.withOpacity(0.8),
                         blurRadius: 10,
                         )
                     ],
                   ),
                   child: Center(
                     child: Text("2",textAlign: TextAlign.center,style: TextStyle(fontWeight:FontWeight.bold,color: Colors.grey),)
                   ),
                ),
                title: Text(
                  "Chính sách quyền riêng tư",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                children: <Widget>[
                  Divider(
                    thickness: 1.0,
                    height: 1.0,
                    indent: 10,
                    endIndent: 10,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5,bottom: 5),
                    width: myWidth*0.9,
                    child: Text(
                    "BKDMS rất coi trọng quyền riêng tư. Dưới đây là các nguyên tắc của chúng tôi.\n 1. Luôn sử dụng thông tin cá nhân của quý khách một cách chân thực và xứng đáng \n 2. Luôn thông báo rõ ràng về những thông tin chúng tôi thu thập \n 3. Thực hiện tất cả các bước hợp lý để bảo vệ thông tin của quý khách \n 4. Tuân thủ theo tất cả các luật và quy định bảo vệ dữ liệu áp dụng đồng thời sẽ hợp tác với các cơ quan bảo vệ dữ liệu. ",
                    style: TextStyle(
                      color: Color(0xff4f5665),
                    ),
                  )),
                ]
              )
            ),
          
          //câu hỏi 3
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: widthDevice*0.05, ),
            child: 
              ExpansionTileCard(
                baseColor: Colors.white,
                initialElevation: 3,
                leading: Container(
                   width: 25,
                   height: 25,
                   decoration: new BoxDecoration(
                     color: Colors.white,
                     shape: BoxShape.circle,
                     boxShadow: [
                       BoxShadow(
                         color: Colors.grey.withOpacity(0.8),
                         blurRadius: 10,
                         )
                     ],
                   ),
                   child: Center(
                     child: Text("3",textAlign: TextAlign.center,style: TextStyle(fontWeight:FontWeight.bold,color: Colors.grey),)
                   ),
                ),
                title: Text(
                  "Chính sách đổi trả hàng",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                children: <Widget>[
                  Divider(
                    thickness: 1.0,
                    height: 1.0,
                    indent: 10,
                    endIndent: 10,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5,bottom: 5),
                    width: myWidth*0.9,
                    child: Text(
                    "Sản phẩm đổi trả phải giữ nguyên 100% hình dạng ban đầu và đủ điều kiện bảo hành của hãng. Chi tiết phụ thuộc vào từng đơn vị cung cấp.",
                    style: TextStyle(
                      color: Color(0xff4f5665),
                    ),
                  )),
                ]
              )
            ),
 
          ]
        ),
      ),
      )
    );
  }
}