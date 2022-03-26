

class Item {
  late int id;
  late String name;
  late String productPrice;
  late String retailPrice;
  late String countryProduce;
  late String dateManufacture;
  late String expirationDate;
  late String barcode;
  late String linkImg;
  late String description;
  late int? categoryId; 
  late int? productlineId;
  late List<dynamic> units;
  late Map? category;
  late Map? productline;  



  Item({
    required this.id,
    required this.name,
    required this.productPrice,
    required this.retailPrice,
    required this.countryProduce,
    required this.dateManufacture,
    required this.expirationDate,
    required this.barcode,
    required this.linkImg,
    required this.description,
    required this.categoryId,
    required this.productlineId,
    required this.units,
    required this.category,
    required this.productline,   
  });
}