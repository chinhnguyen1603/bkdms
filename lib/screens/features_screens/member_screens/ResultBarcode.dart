import 'package:flutter/material.dart';
import 'package:bkdms/components/AppBarTransparent.dart';

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
    return Scaffold(
      appBar: AppBarTransparent(Colors.white,"Kết quả"),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
             SizedBox(height: 20,),
             Text("Mã barcode vừa quét:" + "${widget.resultBarcode}")

          ]
        ),
      ),
      
    );
  }
}