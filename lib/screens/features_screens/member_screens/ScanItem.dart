import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:bkdms/components/AppBarTransparent.dart';
import 'package:bkdms/screens/features_screens/member_screens/ResultBarcode.dart';
import 'package:bkdms/services/ItemProvider.dart';

class ScanItem extends StatefulWidget {
  const ScanItem ({ Key? key }) : super(key: key);

  @override
  State<ScanItem > createState() => ScanItemState();
}


class ScanItemState  extends State<ScanItem> {
  String _scanBarcode = '';
  bool isShowDialog = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBarTransparent(Colors.white,"Quét sản phẩm"),
       backgroundColor: Colors.white,
       body: SingleChildScrollView(child: Center( 
          child: Column(children: [
            SizedBox(height: 30,),
            //icon Loa thông báo
            Image.asset("assets/iconLoa.png"),
            //text dưới loa
            SizedBox(height: 5,),
            Text(
              "Quét mã vạch đối với mỗi sản phẩm bán ra để tạo đơn và tích điểm cho khách hàng",
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 120,),
            //icon barocde on tap
            GestureDetector(
              onTap: () async {
                await scanBarcodeNormal();
                for (var item in Provider.of<ItemProvider>(context, listen: false).lstItem){
                  if(_scanBarcode == item.barcode){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ResultBarcode(_scanBarcode)));
                    setState(() {
                      isShowDialog = false;
                    });
                  }
                }
                if(_scanBarcode != "-1") {
                 isShowDialog
                  ? showDialog(
                        context: context, 
                        builder: (ctx1) => AlertDialog(
                          title: Text("Thông báo", style: TextStyle(fontSize: 22),),
                          content: Text("Sản phẩm đã quét không thuộc danh mục của công ty", style: TextStyle(color: Color(0xff544c4c)),),
                          actions: [TextButton(
                             onPressed: () => Navigator.pop(ctx1),
                             child: Center (child: const Text(
                               'OK',
                               style: TextStyle(decoration: TextDecoration.underline,),
                             ),)
                           ),                      
                          ],                                      
                        )
                      )
                  : Text("");
                }
              },
              child: Container(
                child: Column(
                  children: [
                      //icon Bar code
                      Image.asset("assets/Barcode.png"),
                      //text nhấn vào đây
                      SizedBox(height: 10,),
                      Text(
                         "NHẤN VÀO ĐÂY",
                          style: TextStyle(color: Color(0xff565151), fontSize: 30, fontWeight: FontWeight.bold,),  
                      ),
                      Text("$_scanBarcode"),
                  ],
                ),
              ),
            ), 
          ],),)
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
        });
    }
}