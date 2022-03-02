import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bkdms/HomePage/InfoUser.dart';



class HomePage extends StatelessWidget {
  static const heavyBlue = Color(0xff242266);
  static const textGrey = Color(0xff282323);
  @override
  Widget build(BuildContext context) {
    double widthDevice = MediaQuery.of(context).size.width;// chiều rộng thiết bị
    return Scaffold(
      backgroundColor: Color(0xffF0ECEC),
      body: SingleChildScrollView( 
        child: Column(
          children: [
            // chứa gradient
            Container(
               margin: EdgeInsets.only(top: 30),
               width: double.infinity,
               height: 230,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.only(bottomRight: Radius.circular(50),bottomLeft: Radius.circular(50),),
                 gradient: LinearGradient(
                     begin: Alignment.topRight,
                     end: Alignment.bottomCenter,
                     colors: [Color(0xffFF5151),Color(0xff254FB0)],
                 ),
               ),
               // Column nội dung trong container
               child: Column(
                 children: [
                  SizedBox(height: 10,),
                  
                  //text BKDMS đầu tiên
                  Text(
                     "BKDMS",
                     textAlign: TextAlign.center,
                     style: TextStyle(
                       fontSize: 40,
                       fontFamily: "SegoeScript",
                       color: Colors.white,
                       fontWeight: FontWeight.bold,
                     ),
                   ),
                  
                  //Row chứa Icon và dòng Xin chào khách hàng
                  Container(
                     height: 70,
                     width: widthDevice,
                     child: Row(
                       children: [
                       // Icon User
                       SizedBox(
                         width: widthDevice*0.25,
                         height: 70,
                         child: IconButton(
                          hoverColor: Colors.white,
                          alignment: Alignment.topRight,
                          icon: Icon(
                           Icons.account_circle_outlined,
                           size: 64,
                           color: Color(0xffE0E0E0), 
                          ),                         
                          onPressed: () { 
                            Navigator.push(context, MaterialPageRoute(builder: (context) => InfoUser()));
                          }, 
                          )
                       ),
                       // 2 dòng text
                       Center(
                       child: 
                       Container(
                         margin: EdgeInsets.only(top: 15),
                         height: 70,
                         width: widthDevice*0.5,
                         child: Column(
                            children:[
                              Text(
                               "Xin chào khách hàng ",
                               style: TextStyle(
                               fontSize: 20,
                               fontWeight: FontWeight.w600,
                               color: Colors.white,
                               ),
                              ),
                              SizedBox(height: 3,),
                              Text(
                               "Nguyễn Văn Việt",
                               style: TextStyle(
                               fontSize: 18,
                               fontWeight: FontWeight.w300,
                               color: Colors.white,
                               ),
                              )
                            ]
                         )
                       ))
                     ],
                    ),),
                  
                  // chứa 3 Icon Button Tồn Kho, Thành Viên, Liên hệ
                  SizedBox(height: 25,),
                  Container(
                     width: widthDevice*0.8,
                     height: 54,
                     decoration: BoxDecoration(
                       shape: BoxShape.rectangle,
                       borderRadius: BorderRadius.all(Radius.circular(40)),
                       boxShadow: [
                         BoxShadow(                      
                           blurRadius: 2,
                         ),
                       ],
                       color: Colors.white,
                     ),
                     child: Row(
                       children: [
                         //Icon button tồn kho
                         SizedBox(
                           width: widthDevice*0.26,
                           height: 54,
                           child: Column(
                             children: [
                             SizedBox(
                               height: 26,       
                               child:
                                 IconButton(
                                 alignment: Alignment.center,
                                 onPressed: (){}, 
                                 color: heavyBlue,
                                 padding: EdgeInsets.only(bottom: 1.0, top: 3.0),
                                 icon: Icon(
                                   Icons.outbox_sharp,
                                   size: 32,
                                 )
                               )
                             ),
                              SizedBox(
                                height: 28,
                                child: TextButton(
                                  onPressed: (){
                                     
                                  }, 
                                  child: Text(
                                    "Tồn kho",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: textGrey,
                                    ),
                                  )
                                )
                              )],
                           ),
                          ),
                         VerticalDivider(
                           width: 1,
                           thickness: 1,
                           indent: 7,
                           endIndent: 7,
                           color: Colors.grey,
                         ), 
                         
                         //Icon button thành viên
                         SizedBox(
                           width: widthDevice*0.28,
                           child: Column(
                             children: [
                             SizedBox(
                               height: 26,       
                               child:
                                 IconButton(
                                 onPressed: (){}, 
                                 color: heavyBlue,
                                 padding: EdgeInsets.only(bottom: 1.0, top: 3.0),
                                 icon: Icon(
                                   Icons.star_half_sharp,
                                   size: 34,
                                 )
                               )
                             ),
                              SizedBox(
                                height: 28,
                                child: TextButton(
                                  onPressed: (){
                                     
                                  }, 
                                  child: Text(
                                    "Thành viên",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: textGrey,
                                    ),
                                  )
                                )
                              )],
                           ),                         
                         ),
                         VerticalDivider(
                           width: 1,
                           thickness: 1,
                           indent: 7,
                           endIndent: 7,
                           color: Colors.grey,
                         ),   

                         //Icon button Liên hệ                       
                         SizedBox(
                           width: widthDevice*0.25,
                           child: Column(
                             children: [
                             SizedBox(
                               height: 26,       
                               child:
                                 IconButton(
                                 alignment: Alignment.center,
                                 onPressed: (){

                                 }, 
                                 color: heavyBlue,
                                 padding: EdgeInsets.only(bottom: 1.0, top: 3.0),
                                 icon: Icon(
                                   Icons.local_phone_sharp,
                                   size: 32,
                                 )
                               )
                             ),
                              SizedBox(
                                height: 28,
                                child: TextButton(
                                  onPressed: (){
                                     
                                  }, 
                                  child: SizedBox(
                                    child: Text(
                                    "Liên hệ",      
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: textGrey,
                                    )
                                  ),
                                  )
                                )
                              )],
                           ),                                
                         ),
                       ]
                     ),         
                  ),
                 ]
               )
            ),
            SizedBox(height: 10,),
            
            //Text Khuyến mãi và xem thêm
            SizedBox(
              height: 30,
              width: widthDevice*0.9,
              child: Row(
                children:[
                  SizedBox(
                    width: widthDevice*0.25,
                    child: Text(  
                      "Khuyến mãi",
                      style: TextStyle(
                       fontSize: 18,
                       fontWeight: FontWeight.bold,
                      ),
                    )
                  ),
                  SizedBox(
                    width: widthDevice*0.65,
                    child:
                      TextButton(
                       onPressed: (){}, 
                       child: SizedBox(
                         width: widthDevice*0.65,
                         child: Text(
                          "Xem thêm",
                          textAlign: TextAlign.right,)
                         ),
                      ),
                  )
                ]
              )
            ),
            // chứa ô khuyến mãi
            SizedBox(
              height: 160,
              width: widthDevice,
              child: ListView.builder( 
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder:  (context, index) => Padding(
                  padding: EdgeInsets.all(4.0),
                  child: GestureDetector(
                   onTap: (){
                     print("Click khuyến mãi");
                   },
                   child:Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    width: 160,
                    child: Text(
                      "Voucher $index",
                      textAlign: TextAlign.center,
                      style: TextStyle(

                      ),
                      )
                   )
                  ),
                  ),
              )
            ),
            SizedBox(height: 10,),
            //Text sản phẩm và xem thêm
            SizedBox(
              height: 30,
              width: widthDevice*0.9,
              child: Row(
                children:[
                  SizedBox(
                    width: widthDevice*0.25,
                    child: Text(  
                      "Sản phẩm",
                      style: TextStyle(
                       fontSize: 18,
                       fontWeight: FontWeight.bold,
                      ),
                    )
                  ),
                  SizedBox(
                    width: widthDevice*0.65,
                    child:
                      TextButton(
                       onPressed: (){}, 
                       child: SizedBox(
                         width: widthDevice*0.65,
                         child: Text(
                          "Xem thêm",
                          textAlign: TextAlign.right,)
                         ),
                      ),
                  )
                ]
              )
            ),
            //Gridview sản phẩm
            SizedBox(
              height: 800,
              width: widthDevice*0.98,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8, 
                  mainAxisSpacing: 8,
                ),
                padding: EdgeInsets.all(8),
                primary: false,
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  
                  return GestureDetector(
                    onTap: (){
                      print("click sản phẩm");
                    },
                    child:Container(
                      width: 160,
                      height: 160,
                      color: Colors.white,    
                    ));
                },
              ),
            )
          ],
        ),
      )
    );
  }
}