import 'package:flutter/material.dart';

class ResultBarcode extends StatefulWidget {
  String? resultBarcode;
  ResultBarcode(this.resultBarcode);

  @override
  State<ResultBarcode> createState() => ResultBarcodeState();
}




class ResultBarcodeState extends State<ResultBarcode> {
  List<String> result = [];


  @override
  Widget build(BuildContext context) {
    double widthDevice = MediaQuery.of(context).size.width;// chiều rộng thiết bị
    double myWidth = widthDevice*0.9;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Color(0xff105480),),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: (){
            
            }, 
            icon: Icon(
              Icons.add,
              color: Color(0xff105480),
            )
          )
        ], 
        centerTitle: true,
        title: Text(
            "Kết quả",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Color(0xff105480),),
        )
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
             SizedBox(height: 20,),
             Text("Mã barcode vừa quét:" + "${widget.resultBarcode}")

          ]
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 55,
        width: widthDevice,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 45,
               child: Row(children: [
                 SizedBox(width: widthDevice*0.07,),
                 //Outline button hủy Bỏ
                 SizedBox(
                   height: 45,
                   width: widthDevice*0.4,
                   child: OutlinedButton(
                     onPressed: (){

                     },
                     child: Text("Hủy bỏ", style: TextStyle(color: Color(0xff4690ff), fontWeight: FontWeight.w700),),
                     style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Color(0xff4690ff)),
                     ),
                   )

                 ),
                 SizedBox(width: widthDevice*0.07),
                 //Button hoàn tất
                 SizedBox(
                   height: 45,
                   width: myWidth*0.4,
                   child: ElevatedButton(
                     onPressed: (){

                     },
                     style: ButtonStyle(
                       elevation: MaterialStateProperty.all(0),
                     ), 
                     child: Text("Hoàn tất", style: TextStyle(fontWeight: FontWeight.w700),), 
                   ),
                 ),
               ],),
            ),
            SizedBox(height: 10,)
          ],
        ),
      ),
      
    );
  }
}