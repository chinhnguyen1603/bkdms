import 'package:flutter/material.dart';
import 'package:bkdms/components/AppBarTransparent.dart';


class ResultBarcode extends StatefulWidget {
  const ResultBarcode({ Key? key }) : super(key: key);

  @override
  State<ResultBarcode> createState() => ResultBarcodeState();
}

class ResultBarcodeState extends State<ResultBarcode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTransparent(Colors.white,"Kết quả"),
      
    );
  }
}