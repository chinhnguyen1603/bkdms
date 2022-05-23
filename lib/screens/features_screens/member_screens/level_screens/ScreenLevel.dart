import 'package:bkdms/services/LevelProvider.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';
import 'package:bkdms/components/AppBarTransparent.dart';
import 'package:bkdms/models/Level.dart';
import 'package:bkdms/screens/features_screens/member_screens/level_screens/RegisterHistory.dart';
import 'package:bkdms/screens/features_screens/member_screens/level_screens/RegisterLevel.dart';

class ScreenLevel extends StatefulWidget {
  const ScreenLevel({ Key? key }) : super(key: key);

  @override
  State<ScreenLevel> createState() => _ScreenLevelState();
}

class _ScreenLevelState extends State<ScreenLevel> {
  double myWidth = 90.w;
  List <Color> lstColor = [Color(0xffdeaa23), Color(0xff7b2626), Color(0xff254fb0), Color(0xff23bb86), Color(0xfffa620c), Colors.grey, Colors.black  ]; 
  static const darkGrey = Color(0xff544c4c);
  //List level
  List<Level> lstLevel = [];

  @override
  void initState() {
    super.initState();
    //khởi tạo list level bằng level provider
    lstLevel = Provider.of<LevelProvider>(context, listen: false).lstLevel;
  }

  @override
  Widget build(BuildContext context) {  
    double widthContainer = myWidth*0.9;
    //thêm dấu chấm vào giá sản phẩm
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    String Function(Match) mathFunc = (Match match) => '${match[1]}.';     
    //
    return Scaffold(
      appBar: AppBarTransparent(Colors.white, "Hạn mức"),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(width: 100.w, height: 20,),
            //text Hoạt động
            SizedBox(width: myWidth, child: Text("Hoạt động", style: TextStyle(color: Color(0xff544c4c), fontSize: 18, fontWeight: FontWeight.w500),),),
            SizedBox(height: 20,),

            //đăng kí mới
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterLevel()));
              },
              child: Container(
                width: widthContainer,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(37, 79, 176, 0.3),
                      blurRadius: 25,        
                      offset: Offset(0,2), 
                    )
                  ]
                ),
                alignment: Alignment.center,
                //icon + text + tại đây
                child: SizedBox(
                  width: widthContainer,
                  height: 70,
                  child: Row(
                    children: [
                      //icon
                      SizedBox(
                        width: widthContainer*0.2,
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color(0xfff9fafb),
                              shape: BoxShape.circle,
                            ),   
                            child: SizedBox(height: 30,width: 30, child: Icon(Icons.edit_calendar_outlined, color: Color(0xff5677ff),), )
                        ),
                      ),                         
                      //text + mô tả 
                      SizedBox(
                        height: 60,
                        width: myWidth*0.5,
                        child: Column(
                          children: [
                            SizedBox(height: 12,),
                            SizedBox(
                              width: widthContainer*0.6,
                              child: Text("Đăng kí mới", textAlign: TextAlign.left, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),)
                            ),
                            SizedBox(height: 3,),
                            SizedBox(
                              width: widthContainer*0.6,
                              child: Text("Tham gia để tận hưởng ưu đãi", textAlign: TextAlign.left, maxLines: 1, style: TextStyle(color: darkGrey, fontSize: 13))
                            )
                          ],
                        ),
                      ), 
                      //icon mũi tên
                      SizedBox(
                        height: 60,
                        width: myWidth*0.2,
                        child: Icon(Icons.arrow_forward_ios,)
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),

            //xem lịch sử
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterHistory()));
              },
              child: Container(
                width: widthContainer,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(37, 79, 176, 0.3),
                      blurRadius: 25,        
                      offset: Offset(0,2), 
                    )
                  ]
                ),
                alignment: Alignment.center,
                //icon + text + tại đây
                child: SizedBox(
                  width: widthContainer,
                  height: 70,
                  child: Row(
                    children: [
                      //icon
                      SizedBox(
                        width: widthContainer*0.2,
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color(0xfff9fafb),
                              shape: BoxShape.circle,
                            ),   
                            child: SizedBox(height: 30,width: 30, child: Icon(Icons.difference_outlined, color: Color(0xff5677ff),), )
                        ),
                      ),                         
                      //text + mô tả 
                      SizedBox(
                        height: 60,
                        width: myWidth*0.5,
                        child: Column(
                          children: [
                            SizedBox(height: 12,),
                            SizedBox(
                              width: widthContainer*0.6,
                              child: Text("Xem lịch sử", textAlign: TextAlign.left, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),)
                            ),
                            SizedBox(height: 3,),
                            SizedBox(
                              width: widthContainer*0.6,
                              child: Text("Lịch sử đăng kí hạn mức", textAlign: TextAlign.left, maxLines: 1, style: TextStyle(color: darkGrey, fontSize: 13))
                            )
                          ],
                        ),
                      ), 
                      //icon mũi tên
                      SizedBox(
                        height: 60,
                        width: myWidth*0.2,
                        child: Icon(Icons.arrow_forward_ios,)
                      )
                    ],
                  ),
                ),
              ),
            ),
 
            SizedBox(height: 30,),
            
            //text Thông tin hạn mức
            SizedBox(width: myWidth, child: Text("Thông tin hạn mức", style: TextStyle(color: Color(0xff544c4c), fontSize: 18, fontWeight: FontWeight.w500),),),
            SizedBox(height: 10,),
            ListView.builder(
              itemCount: lstLevel.length,              
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    //chi tiết từng hạn mức
                    Container(
                      width: myWidth,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Color(0xff544c4c)),
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Column(
                        children: [
                          SizedBox(width: 100.w, height: 8,),
                          //tên hạn mức
                          SizedBox(
                            width: myWidth,
                            child: Text(
                              "${lstLevel[index].name}", 
                              textAlign: TextAlign.center,
                              style: TextStyle(color: lstColor[index], fontSize: 18, fontWeight: FontWeight.w500),
                            ), 
                          ),
                          SizedBox(width: 100.w, height: 5,),
                          Divider(thickness: 1,),

                          //điều kiện đạt hạn mức
                          //text điều kiện đạt hạn mức
                          SizedBox(
                            width: myWidth,
                            child: Text("Điều kiện đạt hạn mức", textAlign: TextAlign.left, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),)
                          ),   
                          SizedBox(height: 3,),       
                          //list reward condition
                          ListView.builder(
                            reverse: true,
                            itemCount: lstLevel[index].rewardConditions.length,              
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int indexReward) {
                              //lấy list điều kiện nhận thưởng
                              List<dynamic> lstRewardConditions = [];
                              lstRewardConditions = lstLevel[index].rewardConditions;
                              bool isRevenue = false;
                              //lấy doanh số
                              String revenue = "";
                              if(lstRewardConditions[indexReward]['name'] == "REVENUE") {
                                revenue = lstRewardConditions[indexReward]['value'] + "đ";
                                isRevenue = true;
                              }
                              //lấy số lượng sản phẩm
                              //
                              return Column(
                                children: [
                                  isRevenue
                                  //dấu hỏi là trả về điều kiện doanh số
                                  ?SizedBox(
                                    width: myWidth,
                                    child: Text("Doanh số lớn hơn: ${revenue.replaceAllMapped(reg, mathFunc)}", textAlign: TextAlign.left, maxLines: 1, style: TextStyle(color: darkGrey, fontSize: 13))
                                  )
                                  //dấu chấm trả về điều kiện số lượng sản phẩm
                                  :SizedBox(
                                    width: myWidth,
                                    child: Text(
                                      "Số lượng cần bán: ${lstRewardConditions[indexReward]['value']} ${lstRewardConditions[indexReward]['unit']['name']} ${lstRewardConditions[indexReward]['unit']['product']['name']} (chiết khấu: ${lstRewardConditions[indexReward]['discountValue'].replaceAllMapped(reg, mathFunc)} ${lstRewardConditions[indexReward]['typeDiscount']})",
                                      textAlign: TextAlign.left, maxLines: 3, style: TextStyle(color: darkGrey, fontSize: 13),
                                    )
                                  ),

                                  //ngăn cách các điều kiện
                                  SizedBox(height: 3,),                                  
                                ],
                              );
                            } 
                          ),               
                          SizedBox(height: 5,),


                          //Quà tặng
                          //text quà tặng
                          SizedBox(
                            width: myWidth,
                            child: Text("Quà tặng (nếu có)", textAlign: TextAlign.left, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),)
                          ), 
                          SizedBox(height: 3,),    
                          //list quà tặng gift
                          ListView.builder(
                            reverse: true,
                            itemCount: lstLevel[index].gifts!.length,              
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int indexGift) {
                              //lấy list quà tặng
                              List<dynamic> lstGift = [];
                              if (lstLevel[index].gifts != null) {
                                lstGift = lstLevel[index].gifts as List<dynamic>;
                              }
                              //
                              return Column(
                                children: [
                                  SizedBox(
                                    width: myWidth,
                                    child: Text(
                                      "${lstGift[indexGift]['quantity']} ${lstGift[indexGift]['unit']['name']} ${lstGift[indexGift]['unit']['product']['name']}",                   
                                      textAlign: TextAlign.left, maxLines: 2, style: TextStyle(color: darkGrey, fontSize: 13),
                                    )
                                  ),
                                  //ngăn cách các quà tặng
                                  SizedBox(height: 3,),                                  
                                ],
                              );
                            } 
                          ),               


                          //Thời gian duy trì
                          //text thời gian duy trì
                          SizedBox(
                            width: myWidth,
                            child: Text("Thời gian duy trì", textAlign: TextAlign.left, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),)
                          ),
                          SizedBox(height: 3,),  
                          SizedBox(
                            width: myWidth,
                            child: Text("${lstLevel[index].time['year']} năm ${lstLevel[index].time['month']} tháng ${lstLevel[index].time['day']} ngày", textAlign: TextAlign.center, maxLines: 1, style: TextStyle(color: darkGrey, fontSize: 13))
                          )                          
                        ],
                      ),
                    ),
                    //ngăn cách các container hạn mức
                    SizedBox(height: 20,),
                  ],
                );
              }
            )                     
          ],
        )
      ),
    );
  }


}