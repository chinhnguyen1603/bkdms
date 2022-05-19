
class SaleOrder {
  late String id;
  late String orderCode;
  late String totalPrice;
  late String? name;
  late String? phone;
  late String createTime;
  late List<dynamic> detailOrderEndConsumers;
  SaleOrder({
    required this.id,
    required this.orderCode,
    required this.totalPrice,
    required this.name,
    required this.phone,
    required this.createTime,
    required this.detailOrderEndConsumers,
  });
}
