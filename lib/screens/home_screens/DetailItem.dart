import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bkdms/components/AppBarGrey.dart';
import 'package:bkdms/services/ItemProvider.dart';
import 'package:bkdms/models/Item.dart';


class DetailItem extends StatelessWidget {
  late Item myItem;
  DetailItem(this.myItem);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarGrey("Chi tiết sản phẩm"),
      body: Consumer<ItemProvider>( builder: (ctxItemProvider, itemProvider, child) {
        
        return SingleChildScrollView(
            child: Column(
                children: [
                  Text(myItem.barcode),
                ],
            )
        );
      })
    );
  }
}