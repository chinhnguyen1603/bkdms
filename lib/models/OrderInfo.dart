// list order info để get order
class OrderInfo {
  late String id;
  late String orderCode;
  late String phone;
  late String address;
  late String createTime;
  String? approvedTime;
  String? shippingTime;
  String? completedTime;
  String? cancelledTimeByAgency;
  String? cancelledTimeBySupplier;
  String? returnReason;
  String? waitingDeliveryTime;
  String? deliveredTime;
  String? deliveryFailed;
  String? deliveryFailedReason;
  String? deliveryStatus;
  String? deliveryNote;
  String? deliveryVoucherCode;
  String? note;
  late String orderStatus;
  String? paymentStatus;
  late String type;
  late String totalPayment;
  String? totalDiscount;
  late List<dynamic> orderDetails;

  OrderInfo({
    required this.id,
    required this.orderCode,
    required this.phone,
    required this.address,
    required this.createTime,
    this.approvedTime,
    this.shippingTime,
    this.completedTime,
    this.cancelledTimeByAgency,
    this.cancelledTimeBySupplier,
    this.returnReason,
    this.waitingDeliveryTime,
    this.deliveredTime,
    this.deliveryFailed,
    this.deliveryFailedReason,
    this.deliveryStatus,
    this.deliveryNote,
    this.deliveryVoucherCode,
    this.note,
    required this.orderStatus, 
    this.paymentStatus,
    required this.type,
    required this.totalPayment,
    required this.totalDiscount,
    required this.orderDetails,  
  });
}
