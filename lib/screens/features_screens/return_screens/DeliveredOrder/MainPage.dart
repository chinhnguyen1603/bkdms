import 'package:bkdms/main.dart';
import 'package:bkdms/screens/features_screens/return_screens/ReturnOrder.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:bkdms/models/Agency.dart';
import 'package:bkdms/services/OrderProvider.dart';
import 'package:bkdms/models/OrderInfo.dart';

class MainPageReturn extends StatefulWidget {

  @override
  State<MainPageReturn> createState() => MainPageReturnState();
}


class MainPageReturnState extends State<MainPageReturn> {

  int _pageIndex = 0;
  late PageController _pageController;
  
  //thêm dấu chấm vào giá tiền
  RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  String Function(Match) mathFunc = (Match match) => '${match[1]}.';

  List<Widget> tabPages = [
      HistoryDelivered(),
      ReturnOrder()
  ];

  @override
  void initState(){
    super.initState();
    _pageController = PageController(initialPage: 0);
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
      //bottombar ở đây
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: onTabTapped,
        backgroundColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem( icon: Icon(Icons.history), label: "Lịch sử đơn"),
          BottomNavigationBarItem(icon: Icon(Icons.local_shipping), label: "Đơn trả"),
        ],
        selectedItemColor: Color(0xff105480),
      ),
      body: PageView(
        children: tabPages,
        onPageChanged: onPageChanged,
        controller: _pageController,
      ),
    );
  }
}


//widget lịch sử đơn tại đây
class HistoryDelivered extends StatefulWidget {
  @override
  State<HistoryDelivered> createState() => HistoryDeliveredState();
}


class HistoryDeliveredState extends State<HistoryDelivered> {
  static const heavyBlue = Color(0xff242266);
  static const darkGrey = Color(0xff544c4c);
  List<OrderInfo> lstOrder = [];
  List<OrderInfo> lstSelectDelivered = [];
  bool _isSelecting = false;

  @override
  void initState() {
    super.initState();

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    this.lstOrder = Provider.of<OrderProvider>(context).lstOrderInfo;
  }


 
  @override
  Widget build(BuildContext context) {
    //biến chiều rộng
    double myWidth = 90.w;
    //update lstDelivered show trong widget. Khởi tạo local = [] để up lại từ đầu mỗi khi lstOrder change
    List<OrderInfo> lstDelivered = [];
    for( var order in lstOrder) {
        if (order.completedTime !=null && order.type =="PURCHASE_ORDER"){
          lstDelivered.add(order);
        }
    } 
    //thêm dấu chấm vào giá sản phẩm
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    String Function(Match) mathFunc = (Match match) => '${match[1]}.';    
    //     
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: heavyBlue,
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
            "Trả hàng",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: heavyBlue,),
        )
      ),
      backgroundColor: Color(0xfffafafa),

      //widget body 
      body: SingleChildScrollView( 
          child: Column(
            children: [
              SizedBox(width: 100.w,height: 10),
              //textbutton chọn ngày
              TextButton(
                onPressed: () async{
                  await showDatePicker(
                    context: context, 
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2021), 
                    lastDate: DateTime(2023),
                  ).then((DateTime? value){
                      if(value != null) {
                        DateTime fromDate = DateTime.now();
                        fromDate = value;
                        final String date =  DateFormat('dd/MM/yyyy').format(fromDate);
                        //show toast
                        Fluttertoast.showToast(
                          msg: "Bạn vừa chọn $date",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.CENTER,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 14.0
                        );
                        //build list mới từ date đã chọn
                        setState(() {
                          lstSelectDelivered = lstDelivered
                            .where((element) =>
                               convertTime(element.completedTime!).contains(convertTime("$value")))
                            .toList();  
                          _isSelecting = true;   
                        });         
                      } 
                  });
                  print(lstSelectDelivered);
                }, 
                child: Text("Chọn ngày giao", style: TextStyle(color: Color(0xff7b2626)),)
              ),
              SizedBox(height: 5),
             
              //Listview lịch sử đơn
              _isSelecting
                //khi select ngày thì chỉ ra đơn ngày đó
                ?ListView.builder(
                       itemCount: lstSelectDelivered.length,              
                       shrinkWrap: true,
                       physics: NeverScrollableScrollPhysics(),
                       itemBuilder: (BuildContext context, int index) {
                         return Column(
                           children: [
                             //thông tin đơn hàng đã giao
                             GestureDetector(
                               onTap: (){

                               },
                               //chi tiết đơn
                               child: Container(
                                  width: 90.w,
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Color(0xff1c3a80)),
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color.fromRGBO(28, 58, 128, 0.1),
                                        blurRadius: 10,        
                                        offset: Offset(0,0), 
                                      )
                                    ]
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(width: 100.w, height: 8,),
                                      SizedBox(
                                        width: myWidth,
                                        child: Text(
                                          "Đơn hàng #${lstSelectDelivered[index].orderCode}", 
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Color(0xfffa620c), fontSize: 17, fontWeight: FontWeight.w600),
                                        ), 
                                      ),
                                      SizedBox(width: 100.w, height: 5,),
                                      //Row đơn hàng + tổng tiền
                                      SizedBox(
                                        height: 20,
                                        width: myWidth,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            //tổng tiền
                                            SizedBox(
                                              width: myWidth*0.3,
                                              height: 20,
                                              child: Row(
                                                children: [
                                                  Icon(Icons.attach_money, color: Color(0xff2fab73),),
                                                  Column(
                                                    children: [
                                                      SizedBox(height: 3,),
                                                      Text(
                                                        "${lstSelectDelivered[index].totalPayment.replaceAllMapped(reg, mathFunc)}đ",
                                                        style: TextStyle(color: darkGrey),              
                                                      ),
                                                    ],
                                                  )
                                                ]
                                              )
                                            ),
                                            SizedBox(width: myWidth*0.3,),
                                            //thời gian hoàn thành
                                            SizedBox(
                                              width: myWidth*0.3,
                                              height: 20,
                                              child: Row(
                                                children: [
                                                  Icon(Icons.history, color: Color(0xff7b2626),),
                                                  Column(
                                                    children: [
                                                      SizedBox(height: 3,),
                                                      Text(
                                                        "${convertTime(lstSelectDelivered[index].completedTime as String)}",
                                                        style: TextStyle(color: darkGrey),
                                                        textAlign: TextAlign.right,                        
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      Divider(),

                                      //List view mặt hàng trong đơn
                                      ListView.builder(
                                        itemCount: lstSelectDelivered[index].orderDetails.length,              
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (BuildContext context, int indexOfDetail)  {
                                          return Column(
                                            children: [
                                              //info từng mặt hàng
                                              Container(
                                                height: 50,
                                                width: myWidth*0.9,
                                                alignment: Alignment.center,
                                                child: Row(
                                                  children: [
                                                    //tên mặt hàng + đơn vị
                                                    Column(
                                                      children: [
                                                        SizedBox(
                                                          width: myWidth*0.6,
                                                          child: Text(
                                                            "${lstSelectDelivered[index].orderDetails[indexOfDetail]['unit']['product']['name']}",
                                                            textAlign: TextAlign.left,
                                                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                                                          ),
                                                        ), 
                                                        SizedBox(height: 3,),
                                                        SizedBox(
                                                          width: myWidth*0.6,
                                                          child: Text(
                                                            "Đơn vị: ${lstSelectDelivered[index].orderDetails[indexOfDetail]['unit']['name']}",
                                                            textAlign: TextAlign.left,
                                                          ),
                                                        ),                                                        
                                                      ],
                                                    ),
                                                    //x số lượng
                                                    SizedBox(
                                                      width: myWidth*0.25,
                                                      child: Text(
                                                        "x${lstSelectDelivered[index].orderDetails[indexOfDetail]['quantity']}",
                                                        textAlign: TextAlign.right,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              //divider
                                              SizedBox(
                                                width: myWidth*0.9,
                                                child: Divider(),
                                              )
                                            ],
                                          );
                                        }
                                      ) 
                                    ],
                                  ),
                               ),
                             ),
                             SizedBox(height: 20,),
                           ],
                         );
                       }
                )
  
                //mặc định ban đầu là tất cả ngày
                :ListView.builder(
                       itemCount: lstDelivered.length,              
                       shrinkWrap: true,
                       physics: NeverScrollableScrollPhysics(),
                       itemBuilder: (BuildContext context, int index) {
                         return Column(
                           children: [
                             //thông tin đơn hàng đã giao
                             GestureDetector(
                               onTap: (){

                               },
                               //chi tiết đơn
                               child: Container(
                                  width: 90.w,
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Color(0xff1c3a80)),
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color.fromRGBO(28, 58, 128, 0.1),
                                        blurRadius: 10,        
                                        offset: Offset(0,0), 
                                      )
                                    ]
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(width: 100.w, height: 8,),
                                      SizedBox(
                                        width: myWidth,
                                        child: Text(
                                          "Đơn hàng #${lstDelivered[index].orderCode}", 
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Color(0xfffa620c), fontSize: 17, fontWeight: FontWeight.w600),
                                        ), 
                                      ),
                                      SizedBox(width: 100.w, height: 5,),
                                      //Row đơn hàng + tổng tiền
                                      SizedBox(
                                        height: 20,
                                        width: myWidth,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            //tổng tiền
                                            SizedBox(
                                              width: myWidth*0.3,
                                              height: 20,
                                              child: Row(
                                                children: [
                                                  Icon(Icons.attach_money, color: Color(0xff2fab73),),
                                                  Column(
                                                    children: [
                                                      SizedBox(height: 3,),
                                                      Text(
                                                        "${lstDelivered[index].totalPayment.replaceAllMapped(reg, mathFunc)}đ",
                                                        style: TextStyle(color: darkGrey),              
                                                      ),
                                                    ],
                                                  )
                                                ]
                                              )
                                            ),
                                            SizedBox(width: myWidth*0.3,),
                                            //thời gian hoàn thành
                                            SizedBox(
                                              width: myWidth*0.3,
                                              height: 20,
                                              child: Row(
                                                children: [
                                                  Icon(Icons.history, color: Color(0xff7b2626),),
                                                  Column(
                                                    children: [
                                                      SizedBox(height: 3,),
                                                      Text(
                                                        "${convertTime(lstDelivered[index].completedTime as String)}",
                                                        style: TextStyle(color: darkGrey),
                                                        textAlign: TextAlign.right,                        
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      Divider(),

                                      //List view mặt hàng trong đơn
                                      ListView.builder(
                                        itemCount: lstDelivered[index].orderDetails.length,              
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (BuildContext context, int indexOfDetail)  {
                                          return Column(
                                            children: [
                                              //info từng mặt hàng
                                              Container(
                                                height: 50,
                                                width: myWidth*0.9,
                                                alignment: Alignment.center,
                                                child: Row(
                                                  children: [
                                                    //tên mặt hàng + đơn vị
                                                    Column(
                                                      children: [
                                                        SizedBox(
                                                          width: myWidth*0.6,
                                                          child: Text(
                                                            "${lstDelivered[index].orderDetails[indexOfDetail]['unit']['product']['name']}",
                                                            textAlign: TextAlign.left,
                                                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                                                          ),
                                                        ), 
                                                        SizedBox(height: 3,),
                                                        SizedBox(
                                                          width: myWidth*0.6,
                                                          child: Text(
                                                            "Đơn vị: ${lstDelivered[index].orderDetails[indexOfDetail]['unit']['name']}",
                                                            textAlign: TextAlign.left,
                                                          ),
                                                        ),                                                        
                                                      ],
                                                    ),
                                                    //x số lượng
                                                    SizedBox(
                                                      width: myWidth*0.25,
                                                      child: Text(
                                                        "x${lstDelivered[index].orderDetails[indexOfDetail]['quantity']}",
                                                        textAlign: TextAlign.right,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              //divider
                                              SizedBox(
                                                width: myWidth*0.9,
                                                child: Divider(),
                                              )
                                            ],
                                          );
                                        }
                                      ) 
                                    ],
                                  ),
                               ),
                             ),
                             SizedBox(height: 20,),
                           ],
                         );
                       }
                )
 
            ]
          )
      ),
    );
  }

 

  // Hàm convert thời gian
  String convertTime(String time){
    var timeConvert = DateFormat('dd/MM/yyyy').format(DateTime.parse(time).toLocal());
    return timeConvert;
  }

}