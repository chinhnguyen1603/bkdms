import 'package:bkdms/components/AppBarTransparent.dart';
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


   

 
  @override
  Widget build(BuildContext context) {
    print(DateTime.now());
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
              TextButton(
                onPressed: () async{
                  showDatePicker(
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
                        
                      } 

                  });
                }, 
                child: Text("Chọn ngày giao", style: TextStyle(color: Color(0xff7b2626)),)
              )

            ]
          )
      ),
    );
  }

 

  

}