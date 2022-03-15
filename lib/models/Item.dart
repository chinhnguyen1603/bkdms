import 'package:flutter/cupertino.dart';

class Item with ChangeNotifier{
  late int? id;
  late String? name;
  late String? productPrice;
  late String? aencyPrice;
  late String? retailPrice;
  late String? countryProduce;
  late String? dateManufacture;
  late String? expirationDate;
  late String? quantity;
  late String? productLine;
  late String? barcode;
  late String? sku;
  late String? linkImg;
  late String? description;    

  Item({
    this.id,
    this.name,
    this.productPrice,
    this.aencyPrice,
    this.retailPrice,
    this.countryProduce,
    this.dateManufacture,
    this.expirationDate,
    this.quantity,
    this.productLine,
    this.barcode,
    this.sku,
    this.linkImg,
    this.description,   
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
    );
  }
}