import 'dart:async';
import 'package:bkdms/models/Item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:bkdms/components/AppBarTransparent.dart';
import 'package:bkdms/screens/features_screens/member_screens/ResultBarcode.dart';
import 'package:bkdms/services/ItemProvider.dart';

class ScanItem extends StatefulWidget {
  const ScanItem ({ Key? key }) : super(key: key);

  @override
  State<ScanItem > createState() => _ScanItemState();
}


class _ScanItemState  extends State<ScanItem> {
  String _scanBarcode = '';
  bool isShowDialog = false;
  int needShowDialog = 1;
  
 //khởi tạo list item = []
  List<Item> lstItem = [];

  @override
  void initState() {
    super.initState();
    //lấy list item từ itemprovider
    lstItem = Provider.of<ItemProvider>(context, listen: false).lstItem;
  
  }


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
              // xử lý logic tại đây
              onTap: () async {
                await scanBarcodeNormal();
                for (var item in lstItem){
                  for(var unit in item.units) {
                    if(_scanBarcode == unit['barcode']){
                      setState(() {
                        needShowDialog = 0;
                      });
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ResultBarcode(item, unit)));
                      break;
                    } 
                  }  
                }
                if(needShowDialog == 0) {
                    setState(() {
                       isShowDialog = false;
                    }); 
                }
                else {
                    setState(() {
                       isShowDialog = true;
                    });                   
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