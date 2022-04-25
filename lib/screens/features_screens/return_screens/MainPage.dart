import 'package:bkdms/screens/features_screens/return_screens/ReturnOrder.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:bkdms/models/Agency.dart';
import 'package:bkdms/services/OrderProvider.dart';

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


class HistoryDelivered extends StatefulWidget {

  @override
  State<HistoryDelivered> createState() => HistoryDeliveredState();
}



class HistoryDeliveredState extends State<HistoryDelivered> {
  static const heavyBlue = Color(0xff242266);
  static const textGrey = Color(0xff282323);
  List<String> lstDate = [];
  List<String> lstSelectDate = [];
  List<String> getTimeApi = ["2022-04-15T08:34:12.015Z", "2022-04-16T17:49:55.441Z", "2022-04-17T17:53:32.843Z", "2022-04-20T17:50:42.782Z"]; 
  bool _isSelecting = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for( var time in getTimeApi) {
       this.lstDate.add(convertTime(time));
    }
  }

 
  @override
  Widget build(BuildContext context) {
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
                          lstSelectDate = lstDate
                            .where((element) =>
                               element.contains(convertTime("$value")))
                            .toList();  
                          _isSelecting = true;   
                        });         
                      } 
                  });
                  print(lstSelectDate);
                }, 
                child: Text("Chọn ngày giao", style: TextStyle(color: Color(0xff7b2626)),)
              ),
              SizedBox(height: 5),
             
              //Listview lịch sử đơn
              _isSelecting
                //khi select ngày thì chỉ ra đơn ngày đó
                ?ListView.builder(
                       itemCount: lstSelectDate.length,              
                       shrinkWrap: true,
                       physics: NeverScrollableScrollPhysics(),
                       itemBuilder: (BuildContext context, int index) {
                         return Column(
                           children: [
                             //thông tin đơn hàng đã giao
                             Container(
                                width: 90.w,
                                height: 150,
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
                                child: Text(lstSelectDate[index]),
                             ),
                             SizedBox(height: 20,),
                           ],
                         );
                       }
                )
                //mặc định ban đầu là tất cả ngày
                :ListView.builder(
                       itemCount: lstDate.length,              
                       shrinkWrap: true,
                       physics: NeverScrollableScrollPhysics(),
                       itemBuilder: (BuildContext context, int index) {
                         return Column(
                           children: [
                             //thông tin đơn hàng đã giao
                             Container(
                                width: 90.w,
                                height: 150,
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Color(0xff1c3a80)),
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromRGBO(28, 58, 128, 0.1),
                                      blurRadius: 8,        
                                      offset: Offset(0,0), 
                                    )
                                  ]
                                ),
                                child: Text(lstDate[index]),
                             ),
                             SizedBox(height: 20,),
                           ],
                         );
                       }
                ),
 
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