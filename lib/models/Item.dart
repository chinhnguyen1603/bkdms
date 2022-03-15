import 'package:flutter/cupertino.dart';

class Item with ChangeNotifier{
  late int? id;
  late String? name;
  late String? productPrice;
  late String? agencyPrice;
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
    this.agencyPrice,
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
      name: json['name'],
      productPrice: json['productPrice'],
      agencyPrice: json['agencyPrice'],
      retailPrice: json['retailPrice'],
      countryProduce: json['countryProduce'],
      dateManufacture: json['dateManufacture'],
      expirationDate: json['expirationDate'],
      quantity: json['quantity:'],
      productLine: json['productLine'],
      barcode: json['barcode'],
      sku: json['sku'],
      linkImg: json['linkImg'],
      description: json['description']     
    );
  }
}