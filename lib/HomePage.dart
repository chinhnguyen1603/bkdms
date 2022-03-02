import 'package:flutter/material.dart';
import 'package:bkdms/InfoUser.dart';



class HomePage extends StatelessWidget {
  
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
               height: 235,
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
                  Row(
                     children:[
                       SizedBox(width: 25,),
                       // Icon User
                       SizedBox(
                         width: 30,
                         height: 75,
                         child: IconButton(
                          hoverColor: Colors.white,
                          alignment: Alignment.topLeft,
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
                       SizedBox(width: 47,),
                       // 2 dòng text
                       SizedBox(
                         child: Column(
                            children:[
                              Text(
                               "Xin chào khách hàng ",
                               textAlign: TextAlign.center,
                               style: TextStyle(
                               fontSize: 20,
                               fontWeight: FontWeight.w600,
                               color: Colors.white,
                               ),
                              ),
                              SizedBox(height: 3,),
                              Text(
                               "Nguyễn Văn Việt",
                               textAlign: TextAlign.center,
                               style: TextStyle(
                               fontSize: 18,
                               fontWeight: FontWeight.w300,
                               color: Colors.white,
                               ),
                              )
                            ]
                         )
                       )
                     ],
                    ),
                  
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
                         SizedBox(width: widthDevice*0.25,),
                         VerticalDivider(
                           width: 1,
                           thickness: 1,
                           indent: 7,
                           endIndent: 7,
                           color: Colors.grey,
                         ), 
                         SizedBox(width: widthDevice*0.295,),
                         VerticalDivider(
                           width: 1,
                           thickness: 1,
                           indent: 7,
                           endIndent: 7,
                           color: Colors.grey,
                         ),                          
                         SizedBox(width: widthDevice*0.2,),
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
                  child: Container(
                    width: 160,
                    color: Colors.white,
                    child: Text(
                      "Voucher $index",
                      textAlign: TextAlign.center,
                      style: TextStyle(

                      ),
                      )
                    ),
                  ),
              )
            ),
           
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
                  
                  return Container(
                    width: 160,
                    height: 160,
                    color: Colors.white,    
                  );
                },
              ),
            )
          ],
        ),
      )
    );
  }
}