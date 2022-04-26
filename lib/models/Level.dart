
class Level {
  late String id;
  late String name;
  late String discountRange;
  late Map time;
  late List<dynamic> registrationConditions;
  late List<dynamic> rewardConditions;
  late List<dynamic> gifts;



  Level({
    required this.id,
    required this.name,
    required this.discountRange,
    required this.time,
    required this.registrationConditions,
    required this.rewardConditions,
    required this.gifts,
  });
}

class RewardCondition {
  late String id;
  late String name;
  late String value;
  late String? maxAmount;
  late String? typeDiscount;
  late String? discountValue;
  late List<dynamic> unit;



  RewardCondition({
    required this.id,
    required this.name,
    required this.value,
    required this.maxAmount,
    required this.typeDiscount,
    required this.discountValue,
    required this.unit,
  });    
}
