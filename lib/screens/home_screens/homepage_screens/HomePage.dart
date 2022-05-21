import 'package:bkdms/screens/features_screens/return_screens/DeliveredOrder/MainPage.dart';
import 'package:bkdms/services/LevelProvider.dart';
import 'package:bkdms/services/OrderProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'InfoUser.dart';
import 'package:bkdms/screens/features_screens/contact_screens/Contact.dart';
import 'package:bkdms/screens/features_screens/member_screens/Member.dart';
import 'package:bkdms/models/Agency.dart';
import 'package:bkdms/services/ItemProvider.dart';
import 'package:bkdms/screens/home_screens/homepage_screens/ShowListItem.dart';
import 'package:bkdms/screens/home_screens/order_status_screen/ScreenOrder.dart';
import 'package:bkdms/screens/home_screens/stat_screen/ScreenStat.dart';
import 'package:bkdms/screens/home_screens/homepage_screens/DetailItem.dart';
import 'package:bkdms/services/CartProvider.dart';
import 'package:bkdms/models/CountBadge.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';

//local notification nhắc thanh toán nợ
const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.high,
    playSound: true
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();



class HomePage extends StatefulWidget {
  late int index;
  HomePage(this.index);
  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {

  late int _pageIndex;
  late PageController _pageController;
  DateTime? currentBackPressTime;

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
    _pageController = PageController(initialPage: widget.index);
    _pageIndex = widget.index;
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

    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        backgroundColor: Color(0xffF0ECEC),
        //bottombar ở đây
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
     
     
      ),
    );
  }

  //nhấn 2 lần để thoát màn hình
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null || now.difference(currentBackPressTime as DateTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      //show toast
      Fluttertoast.showToast(
        msg: "Nhấn một lần nữa để thoát",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 14.0
      );
      return Future.value(false);
    }
    Fluttertoast.cancel();
    SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
    return Future.value(true);
  }  
}


class ScreenHome extends StatefulWidget {

  @override
  State<ScreenHome> createState() => ScreenHomeState();
}



class ScreenHomeState extends State<ScreenHome> {
  static const heavyBlue = Color(0xff242266);
  static const textGrey = Color(0xff282323);

  //biến Agency để lấy dư nọ hiện tại + dư nợ tối đa
  late Agency user;

  @override
  void initState() {
    super.initState();
    user = Provider.of<Agency>(context, listen: false);
  }

 
  @override
  Widget build(BuildContext context) {
    double widthDevice = 100.w;// chiều rộng thiết bị
    double myWidth = widthDevice*0.9;
    //
    return SingleChildScrollView( 
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
                         width: widthDevice*0.2,
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
                        child:  Container(
                            margin: EdgeInsets.only(top: 15),
                            height: 70,
                            width: widthDevice*0.6,
                            child: Column(
                              children:[
                                SizedBox(
                                  width: widthDevice*0.6,
                                  child: Text(
                                    "Xin chào khách hàng ",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white,),
                                  ),
                                ),
                                SizedBox(height: 3,),
                                SizedBox(
                                  width: widthDevice*0.6,
                                  child: Text(
                                    "${user.nameOwn}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle( fontSize: 18, fontWeight: FontWeight.w300, color: Colors.white,),
                                  ),
                                )
                              ]
                            )
                        )             
                       )],
                    ),),
                  
                  // chứa 3 Icon Button Trả hàng, Thành Viên, Liên hệ
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
                         //Icon button trả hàng
                         SizedBox(
                           width: widthDevice*0.26,
                           height: 54,
                           child: InkWell(
                           splashColor: Colors.deepOrange,
                           onTap: () async{
                             //show dialog chờ get order
                             await showDialog (
                               context: context,
                               builder: (context) =>
                                 FutureProgressDialog(getOrderFuture()),
                             ); 
                             Navigator.push(context, MaterialPageRoute(builder: (context) => MainPageReturn(0)));
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
                                  "Trả hàng",      
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
                           onTap: () async {
                              //nhắc thanh toán công nợ
                              // if công nợ > 0 thì mới tính
                              if(user.currentTotalDebt != "0"){
                                if(user.debtStartTime != null && user.maxDebtPeriod != null) {
                                  //nếu d2 nhỏ hơn d1 thì trả về true. Lấy mốc trước mốc phải trả 5 ngày để so
                                  var today = DateTime.now().toLocal();     
                                  var beforeDay =  DateTime.parse(user.debtStartTime as String).add(Duration(days: int.parse(user.maxDebtPeriod as String))).subtract(Duration(days: 5));
                                  var afterDay =  DateTime.parse(user.debtStartTime as String).add(Duration(days: int.parse(user.maxDebtPeriod as String)+1));
                                  if(beforeDay.compareTo(today) < 0){
                                    if(afterDay.compareTo(today) < 0){
                                      //nếu hôm nay lớn hơn afterDay thì loại
                                    }else{
                                      //show thông báo tại đây
                                      showNotification(convertPeriodTime(user.debtStartTime as String, int.parse(user.maxDebtPeriod as String)));
                                    }
                                  }  
                                } 
                              }                           
                              //show dialog chờ get order
                              await showDialog (
                                context: context,
                                builder: (context) =>
                                  FutureProgressDialog(getOrderFuture()),
                              );
                              //move to member
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
            SizedBox(width: 100.w, height: 10,),
            
            //Text Khuyến mãi và xem thêm
            SizedBox(
              height: 30,
              width: myWidth,
              child: Row(
                children:[
                  SizedBox(
                    width: myWidth*0.5,
                    child: Text(  
                      "Khuyến mãi",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold,),
                    )
                  ),
                  SizedBox(
                    width: myWidth*0.5,
                    child:
                      TextButton(
                       onPressed: () async{
                      }, 
                       child: SizedBox(
                         width: widthDevice*0.5,
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
              height: 70,
              width: widthDevice*0.98,
              child: ListView.builder( 
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder:  (context, index) => Padding(
                  padding: EdgeInsets.all(4.0),
                  child: GestureDetector(
                   onTap: ()async{
                      Agency user = Provider.of<Agency>(context, listen: false);
                      await Provider.of<LevelProvider>(context, listen: false).getHistoryLevel(user.token, user.workspace, user.id);
                   },
                   child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    width: 180,
                    height: 70,
                    child: Image.asset("assets/voucher.png")
                   )
                  ),
                  ),
              )
            ),
            SizedBox(height: 10,),
 
            //Text sản phẩm và xem thêm
            SizedBox(
              height: 30,
              width: myWidth,
              child: Row(
                children:[
                  //text sản phẩm
                  SizedBox(
                    width: myWidth*0.5,
                    child: Text(  
                      "Sản phẩm",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold,),
                    )
                  ),
                  //text xem thêm
                  SizedBox(
                    width: myWidth*0.5,
                    child:
                      TextButton(
                       onPressed: () async{
                          //show dialog chờ get cart
                          await showDialog (
                             context: context,
                             builder: (context) =>
                             FutureProgressDialog(getCartFuture()),
                          ); 
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ShowListItem()));
                       }, 
                       child: SizedBox(
                         width: myWidth*0.5,
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

  // hàm get cart
  Future getCartFuture() {
    return Future(() async {
      Agency user = Provider.of<Agency>(context, listen: false);
      await Provider.of<CartProvider>(context, listen: false).getCart(user.token, user.workspace, user.id);
      Provider.of<CountBadge>(context, listen: false).setCounter(Provider.of<CartProvider>(context, listen: false).lstCart.length);   
    });
  }   

  // hàm get order
  Future getOrderFuture() {
    return Future(() async {
      Agency user = Provider.of<Agency>(context, listen: false);
      await Provider.of<OrderProvider>(context, listen: false).getOrder(user.token, user.workspace, user.id)
     .catchError((onError) async {
          String fault = onError.toString().replaceAll("{", ""); // remove {
          String outputError = fault.replaceAll("}", ""); //remove }         
          // Alert Dialog khi lỗi xảy ra
          print("Bắt lỗi future dialog get order");
          await showDialog(
              context: context, 
              builder: (ctx1) => AlertDialog(
                  title: Text("Oops! Có lỗi xảy ra", style: TextStyle(fontSize: 24),),
                  content: Text("$outputError"),
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
  
  // hàm lấy ảnh từ cloudinary
  String getUrlFromLinkImg(String linkImg) {
        //linkImg receive from server as Public Id
        final cloudinaryImage = CloudinaryImage.fromPublicId("di6dsngnr", linkImg);
        String transformedUrl = cloudinaryImage.transform().width(256).thumb().generate()!;
        return transformedUrl;
  }

  void showNotification(String date) {
    flutterLocalNotificationsPlugin.show(
        0,
        "Nhắc thanh toán công nợ",
        "Ngày $date là hạn đóng công nợ, bạn hãy vào BKDMS để thanh toán ngay nhé",
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name, 
                importance: Importance.high,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher')
        )
    );
  }

  // Hàm show UI mốc phải trả nợ
  String convertPeriodTime(String inputTime, int inputMaxDebtPeriod){
    var debtStartTime = DateTime.parse(inputTime).toLocal();  
    var endTime = debtStartTime.add( Duration(days: inputMaxDebtPeriod));
    //mốc nợ sau cùng
    var timeConvert = DateFormat('dd/MM').format(endTime);
    return timeConvert;
  }

}