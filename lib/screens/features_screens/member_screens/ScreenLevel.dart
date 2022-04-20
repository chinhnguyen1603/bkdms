import 'package:bkdms/screens/features_screens/member_screens/level_screens/HistoryRegister.dart';
import 'package:flutter/material.dart';
import 'package:bkdms/components/AppBarTransparent.dart';
import 'package:sizer/sizer.dart';

class ScreenLevel extends StatelessWidget {
  const ScreenLevel({ Key? key }) : super(key: key);
  static const heavyBlue = Color(0xff242266);

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
            "Hạn mức",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: heavyBlue,),
        )
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Color(0xfff5f0ff), Color(0xfff5f4ff), Color(0xfff5f9ff),Color(0xffdef0f8),Color(0xff71Defc)],       
          ),       
        ),
        child: Container(
          height: 100.h,
          width: 100.w,
          child: Column(
            children: [
              SizedBox(
                width: 100.w,
                height: 20.h,
              ),
              SizedBox(
                height: 40.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //thông tin
                    SizedBox(
                      width: 70.w,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: (){

                        }, 
                        style: ButtonStyle(
                           elevation: MaterialStateProperty.all(0),
                           backgroundColor:  MaterialStateProperty.all<Color>(Colors.white),
                           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                               RoundedRectangleBorder( borderRadius: BorderRadius.circular(10.0),)
                           )
                        ),
                        child: Text("Thông tin", style: TextStyle(color: Color(0xff6c3131), fontSize: 18, fontWeight: FontWeight.w700),),
                      ),
                    ),
                    //Đăng kí
                    SizedBox(
                      width: 70.w,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: (){

                        }, 
                        style: ButtonStyle(
                           elevation: MaterialStateProperty.all(0),
                           backgroundColor:  MaterialStateProperty.all<Color>(Colors.white),
                           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                               RoundedRectangleBorder( borderRadius: BorderRadius.circular(10.0),)
                           )
                        ),
                        child: Text("Đăng kí", style: TextStyle(color: Color(0xff6c3131), fontSize: 18, fontWeight: FontWeight.w700),),
                      ),
                    ),
                    //Lịch sử đăng kí
                    SizedBox(
                      width: 70.w,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: (){
                           Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryRegister()));
                        }, 
                        style: ButtonStyle(
                           elevation: MaterialStateProperty.all(0),
                           backgroundColor:  MaterialStateProperty.all<Color>(Colors.white),
                           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                               RoundedRectangleBorder( borderRadius: BorderRadius.circular(10.0),)
                           )
                        ),
                        child: Text("Lịch sử đăng kí", style: TextStyle(color: Color(0xff6c3131), fontSize: 18, fontWeight: FontWeight.w700),),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      
    );
  }
}