

class Item {
  late int? id;
  late String? name;
  late String? productPrice;
  late String? retailPrice;
  late String? countryProduce;
  late String? dateManufacture;
  late String? expirationDate;
  late String? barcode;
  late String? linkImg;
  late String? description;
  late int? categoryId; 
  late int? productlineId;
  late List<dynamic> units;
  late Map? category;
  late Map? productline;  



  Item({
    this.id,
    this.name,
    this.productPrice,
    this.retailPrice,
    this.countryProduce,
    this.dateManufacture,
    this.expirationDate,
    this.barcode,
    this.linkImg,
    this.description,
    this.categoryId,
    this.productlineId,
    required this.units,
    this.category,
    this.productline,   
  });
}