import 'package:flutter/material.dart';
import 'package:bkdms/components/AppBarTransparent.dart';
import 'package:sizer/sizer.dart';

class ScreenLevel extends StatelessWidget {
  const ScreenLevel({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTransparent(Colors.white,"Hạn mức"),
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
                      width: 60.h,
                      height: 45,
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
                        child: Text("Thông tin", style: TextStyle(color: Color(0xff6c3131)),),
                      ),
                    ),
                    //Đăng kí
                    SizedBox(
                      width: 60.h,
                      height: 45,
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
                        child: Text("Đăng kí", style: TextStyle(color: Color(0xff6c3131)),),
                      ),
                    ),
                    //Lịch sử đăng kí
                    SizedBox(
                      width: 60.h,
                      height: 45,
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
                        child: Text("Lịch sử đăng kí", style: TextStyle(color: Color(0xff6c3131)),),
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