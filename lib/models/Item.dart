

class Item {
  late String id;
  late String name;
  late String? countryProduce;
  late String? type;
  late String? dateManufacture;
  late String? expirationDate;
  late String linkImg;
  late String? description;
  late String? categoryId; 
  late String? productlineId;
  late List<dynamic> units;



  Item({
    required this.id,
    required this.name,
    required this.countryProduce,
    required this.type,
    required this.dateManufacture,
    required this.expirationDate,
    required this.linkImg,
    required this.description,
    required this.categoryId,
    required this.productlineId,
    required this.units, 
  });
}