import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import './InfoUser.dart';
import 'package:bkdms/screens/features_screens/contact_screens/Contact.dart';
import 'package:bkdms/screens/features_screens/member_screens/Member.dart';
import 'package:bkdms/models/Agency.dart';
import 'package:bkdms/models/Item.dart';
import 'package:bkdms/services/ItemProvider.dart';
import 'package:bkdms/screens/home_screens/ShowListItem.dart';
import 'package:bkdms/screens/home_screens/order_status_screen/ScreenOrder.dart';
import 'package:bkdms/screens/home_screens/stat_screen/ScreenStat.dart';
import 'package:bkdms/screens/home_screens/DetailItem.dart';
import 'package:bkdms/services/CartProvider.dart';
import 'package:bkdms/models/CountBadge.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => HomePageState();
}


class HomePageState extends State<HomePage> {



   int _pageIndex = 0;
  late PageController _pageController;
  
  //thêm dấu chấm vào giá tiền
  RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  String Function(Match) mathFunc = (Match match) => '${match[1]}.';

  List<Widget> tabPages = [
      ScreenHome(),
      ScreenOrder(),
      ScreenStat(),
  ];

  @override
  void initState(){
    super.initState();
    _pageController = PageController(initialPage: _pageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      this._pageIndex = page;
    });
  }

  void onTabTapped(int index) {
    this._pageController.animateToPage(index,duration: const Duration(milliseconds: 500),curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xffF0ECEC),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: onTabTapped,
        backgroundColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem( icon: Icon(Icons.home), label: "Trang chủ"),
          BottomNavigationBarItem(icon: Icon(Icons.local_shipping), label: "Đơn hàng"),
          BottomNavigationBarItem(icon: Icon(Icons.query_stats), label: "Thống kê"),
        ],
        selectedItemColor: Colors.amber[800],
      ),
      body: PageView(
        children: tabPages,
        onPageChanged: onPageChanged,
        controller: _pageController,
      ),
 
 
    );
  }
}


class ScreenHome extends StatefulWidget {

  @override
  State<ScreenHome> createState() => ScreenHomeState();
}



class ScreenHomeState extends State<ScreenHome> {
  static const heavyBlue = Color(0xff242266);
  static const textGrey = Color(0xff282323);


   

 
  @override
  Widget build(BuildContext context) {
    double widthDevice = MediaQuery.of(context).size.width;// chiều rộng thiết bị
    return SingleChildScrollView( 
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
              height: 100,
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
                   child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    width: 160,
                    height: 120,
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
                  //text sản phẩm
                  SizedBox(
                    width: widthDevice*0.25,
                    child: Text(  
                      "Sản phẩm",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),
                    )
                  ),
                  //text xem thêm
                  SizedBox(
                    width: widthDevice*0.65,
                    child:
                      TextButton(
                       onPressed: () {
                         Navigator.push(context, MaterialPageRoute(builder: (context) => ShowListItem()));
                       }, 
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

            //Gridview sản phẩm khi get API
            SizedBox(
              height: 700,
              width: widthDevice*0.98,
              child: Consumer<ItemProvider>( builder: (ctxItemProvider, itemProvider, child) {  
               return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                    childAspectRatio: 1/1.2,
                ),
                padding: EdgeInsets.all(8),
                primary: false,
                itemCount: itemProvider.lstItem.length,
                itemBuilder: (BuildContext context, int index) {
                    // thêm dấu chấm vào giá sản phẩm 
                    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
                    String Function(Match) mathFunc = (Match match) => '${match[1]}.';
                    //Xử lý đơn vị và chuyển đơn vị
                    var baseUnit;
                    List<dynamic> switchUnit = [];
                    for(var unit in itemProvider.lstItem[index].units){
                        if(unit['isBaseUnit'] == true) {
                          baseUnit = unit;
                        } else {
                          switchUnit.add(unit);
                        }
                    }
                    return  Container(
                            color: Colors.white,
                            child: Column(
                                children: [
                                    // Ảnh sản phẩm
                                    GestureDetector(
                                        onTap: (){
                                           Navigator.push(context, MaterialPageRoute(builder: (context) => DetailItem(itemProvider.lstItem[index],baseUnit,switchUnit,itemProvider.lstItem[index].units)));
                                       },
                                        child: Image.network(
                                            getUrlFromLinkImg("${itemProvider.lstItem[index].linkImg}"),
                                            width: widthDevice*0.38,
                                            height: widthDevice * 0.38,                       
                                       ),
                                    ),
                                    //Tên sản phẩm
                                    SizedBox(height: 10, ),
                                    GestureDetector(
                                        onTap: (){
                                           Navigator.push(context, MaterialPageRoute(builder: (context) => DetailItem(itemProvider.lstItem[index],baseUnit,switchUnit,itemProvider.lstItem[index].units)));
                                        },
                                        child: SizedBox(
                                            height: 28 ,
                                            width: widthDevice*0.4,
                                            child: Text(
                                               "${itemProvider.lstItem[index].name}",
                                               maxLines: 2, 
                                               overflow: TextOverflow.ellipsis,
                                               softWrap: false,
                                               style: TextStyle(fontSize: 12),
                                        )
                                    ),),
                                    // Price Agency 
                                    SizedBox(
                                        height: 20,
                                        width: widthDevice*0.4,
                                        child: Row(
                                          children: [
                                             // Price baseUnit Agency
                                             SizedBox(
                                               height: 20,
                                               width: widthDevice*0.34,
                                               child: Text(
                                                 "${baseUnit['agencyPrice'].replaceAllMapped(reg, mathFunc)}" + 'đ',
                                                 style: TextStyle(fontSize:16, color: Color(0xffb01313))
                                               ),
                                             ),
                                         ]
                                        )
                                    ),
                                ]
                            )
                        );
                },   
              );
              
              },) 
            )
          ],
        ),
      );
 
  }
  
  // hàm lấy ảnh từ cloudinary
  String getUrlFromLinkImg(String linkImg) {
        //linkImg receive from server as Public Id
        final cloudinaryImage = CloudinaryImage.fromPublicId("di6dsngnr", linkImg);
        String transformedUrl = cloudinaryImage.transform().width(256).thumb().generate()!;
        return transformedUrl;
  }
}