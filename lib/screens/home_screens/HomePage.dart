import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './InfoUser.dart';
import 'package:bkdms/screens/features_screens/Contact.dart';
import 'package:bkdms/screens/features_screens/Member.dart';
import 'package:bkdms/models/Agency.dart';
import 'package:bkdms/models/Item.dart';
import 'package:bkdms/services/FetchListItem.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => HomePageState();
}


class HomePageState extends State<HomePage> {
  static const heavyBlue = Color(0xff242266);
  static const textGrey = Color(0xff282323);

  late Future<List<dynamic>> futureItem;
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Agency? user = Provider.of<Agency>(context);
    futureItem =  fetchListItem(user.token, user.workspace);
  }

  @override
  Widget build(BuildContext context) {
    double widthDevice = MediaQuery.of(context).size.width;// chiều rộng thiết bị
    return Scaffold(
      backgroundColor: Color(0xffF0ECEC),
      body: SingleChildScrollView( 
        child: Column(
          children: [
            // Container chứa gradient
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
                         // Gọi object từ Provider Agency
                        child: Consumer<Agency?>( builder: (ctx, user, child) { 
                          String? userName = user?.nameOwn; 
                          return Container(
                            margin: EdgeInsets.only(top: 15),
                            height: 70,
                            width: widthDevice*0.5,
                            child: Column(
                            children:[
                              Text(
                               "Xin chào khách hàng ",
                               style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white,),
                              ),
                              SizedBox(height: 3,),
                              Text(
                               "$userName",
                               style: TextStyle( fontSize: 18, fontWeight: FontWeight.w300, color: Colors.white,),
                              )
                            ]
                         )
                        );
                        // builder
                        })                    
                       )],
                    ),),
                  
                  // chứa 3 Icon Button Tồn Kho, Thành Viên, Liên hệ
                  SizedBox(height: 25,),
                  //Container màu trắng bọc ngoài
                  Container(
                     width: widthDevice*0.8,
                     height: 54,
                     decoration: BoxDecoration(
                       shape: BoxShape.rectangle,
                       borderRadius: BorderRadius.all(Radius.circular(40)),
                       boxShadow: [BoxShadow(blurRadius: 2,),],
                       color: Colors.white,
                     ),
                     child: Row(
                       children: [
                         //Icon button tồn kho
                         SizedBox(
                           width: widthDevice*0.26,
                           height: 54,
                           child: InkWell(
                           splashColor: Colors.deepOrange,
                           onTap: (){
                             //Navigator.push(context, MaterialPageRoute(builder: (context) => InfoUser()));
                           },
                           child: Container( 
                           margin: EdgeInsets.only(top:5) ,
                           child:                             
                            Column(
                             children: [
                             SizedBox(
                               height: 25,       
                               child:
                                 Icon(
                                   Icons.outbox_sharp,
                                   size: 32,
                                   color: heavyBlue,
                                 )
                               ),
                              SizedBox(height: 5,),                    
                              SizedBox(
                                height: 15,
                                child: Text(
                                  "Tồn kho",      
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: textGrey,
                                      fontWeight: FontWeight.w500,
                                    )
                                  ),
                                  )
                              ],
                           ),                                
                           ),
                           )
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
                           height: 54,
                           child: InkWell(
                           splashColor: Colors.deepOrange,
                           onTap: (){
                             Navigator.push(context, MaterialPageRoute(builder: (context) => Member()));
                           },
                           child: Container( 
                           margin: EdgeInsets.only(top:5) ,
                           child:                             
                            Column(
                             children: [
                             SizedBox(
                               height: 25,       
                               child:
                                 Icon(
                                   Icons.star_half_sharp,
                                   size: 32,
                                   color: heavyBlue,
                                 )
                               ),
                              SizedBox(height: 5,),                    
                              SizedBox(
                                height: 15,
                                child: Text(
                                  "Thành viên",      
                                  style: TextStyle(fontSize: 12, color: textGrey, fontWeight: FontWeight.w500, )
                                  ),
                                  )
                              ],
                           ),                                
                           ),
                           )
                       ),
                         VerticalDivider(
                           width: 1,
                           thickness: 1,
                           indent: 7,
                           endIndent: 7,
                           color: Colors.grey,
                         ),   

                         //Icon button  Liên hệ                                                
                         SizedBox(
                           width: widthDevice*0.25,
                           height: 54,
                           child: 
                           InkWell(
                           splashColor: Colors.deepOrange,
                           onTap: (){
                             Navigator.push(context, MaterialPageRoute(builder: (context) => Contact()));
                           },
                           child: Container( 
                           margin: EdgeInsets.only(top:5) ,
                           child:                             
                            Column(
                             children: [
                             SizedBox(
                               height: 25,       
                               child:
                                 Icon(
                                   Icons.local_phone_sharp,
                                   size: 32,
                                   color: heavyBlue,
                                 )
                               ),
                              SizedBox(height: 5,),                    
                              SizedBox(
                                height: 15,
                                child: Text(
                                  "Liên hệ",      
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: textGrey,
                                      fontWeight: FontWeight.w500,
                                    )
                                  ),
                                  )
                              ],
                           ),                                
                           ),
                           )
                         )
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
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),
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
                          textAlign: TextAlign.right,
                          )
                       ),
                      ),
                  )
                ]
              )
            ),
            // chứa ô khuyến mãi
            SizedBox(
              height: 140,
              width: widthDevice*0.98,
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
              height: 600,
              width: widthDevice*0.95,
              child: FutureBuilder<List<dynamic>>(
                future: futureItem,
                builder: (ctxItem, snapshot){
                   if (snapshot.hasData) {
                     List<dynamic> listItem = snapshot.data!; // đây là list Item thu được
                     // build gridview
                     return GridView.builder(
                       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8, 
                          mainAxisSpacing: 8,
                       ),
                       padding: EdgeInsets.all(8),
                       primary: false,
                       itemCount: listItem.length,
                       itemBuilder: (BuildContext context, int index) {                
                         return GestureDetector(
                           onTap: (){
                             print("click sản phẩm");
                           },
                           child:Container(
                             width: 160,
                             height: 160,
                             color: Colors.white,    
                             child: Text("${listItem[index].name}"),
                           ));
                       },
                     );
                   }
                   else if (snapshot.hasError) {
                      throw "${snapshot.error}";
                   }
                   return Container(child: CircularProgressIndicator());
                })
            )],
        ),
      )
    );
  }
}