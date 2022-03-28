import 'dart:async';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:bkdms/services/ItemProvider.dart';

class ResultBarcode extends StatefulWidget {
  late String resultBarcode;
  ResultBarcode(this.resultBarcode);

  @override
  State<ResultBarcode> createState() => ResultBarcodeState();
}




class ResultBarcodeState extends State<ResultBarcode> {
  List<String> result =[];
  String _scanBarcode = '';

  @override
  void initState() {
    super.initState();
  }
 /* 
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    List<Item> lstItem = Provider.of<ItemProvider>(context).lstItem;
    String result0 = widget.resultBarcode; 
    for (var item in lstItem){
      if(widget.resultBarcode == item.barcode){
        result.add(result0);
      }
    }  
  }*/

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
            onPressed: () async {
              await scanBarcodeNormal(); 
            }, 
            icon: Icon(
              Icons.add,
              color: Color(0xff105480),
              size: 30,
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
      body: Consumer<ItemProvider>( builder: (ctxItemProvider, itemProvider, child) {
       
       return SingleChildScrollView(
        child: Column(
          children: [
             SizedBox(height: 20,),
             Text("$result"),
             Text("biến mới quét là "),

          ]
        ),
       );
      }),
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
                 SizedBox(width: widthDevice*0.05,),
                 //Outline button hủy Bỏ
                 SizedBox(
                   height: 40,
                   width: widthDevice*0.425,
                   child: OutlinedButton(
                     onPressed: (){

                     },
                     child: Text("Hủy bỏ", style: TextStyle(color: Color(0xff4690ff), fontWeight: FontWeight.w700),),
                     style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Color(0xff4690ff)),
                     ),
                   )

                 ),
                 SizedBox(width: widthDevice*0.05),
                 //Button hoàn tất
                 SizedBox(
                   height: 40,
                   width: myWidth*0.45,
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


  // Function scan barcode
    Future<void> scanBarcodeNormal() async {
        String barcodeScanResponse;
        // Platform messages may fail, so we use a try/catch PlatformException.
        try {
            barcodeScanResponse = await FlutterBarcodeScanner.scanBarcode(
                '#ff6666', 'Hủy bỏ', true, ScanMode.BARCODE);
        }
        on PlatformException {
            barcodeScanResponse = 'Có lỗi xảy ra ở thiết bị';
        }

        // If the widget was removed from the tree while the asynchronous platform
        // message was in flight, we want to discard the reply rather than calling
        // setState to update our non-existent appearance.
        if (!mounted) return;

        setState(() {
            _scanBarcode = barcodeScanResponse;
            for (var item in Provider.of<ItemProvider>(context, listen: false).lstItem){
               if(_scanBarcode == item.barcode){
                   result.add(_scanBarcode);
               }
            } 
        });
  
    }
}