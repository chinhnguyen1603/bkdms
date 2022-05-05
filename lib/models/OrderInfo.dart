
class OrderInfo {
  late String id;
  late String orderCode;
  late String phone;
  late String address;
  late String extraInfoOfAddress;
  late String ward;
  late String district;
  late String province;
  late String createTime;
  String? approvedTime;
  String? completedTime;
  String? cancelledTimeByAgency;
  String? cancelledTimeBySupplier;
  String? returnReason;
  String? deliveredTime;
  String? note;
  late String orderStatus;
  String? paymentStatus;
  late String paymentType;
  late String type;
  late String totalPayment;
  String? totalDiscount;
  late List<dynamic> orderDetails;
  late List<dynamic>? wayBills;

  OrderInfo({
    required this.id,
    required this.orderCode,
    required this.phone,
    required this.address,
    required this.extraInfoOfAddress,
    required this.ward,
    required this.district,
    required this.province,
    required this.createTime,
    required this.approvedTime,
    required this.completedTime,
    required this.cancelledTimeByAgency,
    required this.cancelledTimeBySupplier,
    required this.returnReason,
    required this.deliveredTime,
    required this.paymentType,
    required this.note,
    required this.orderStatus, 
    required this.paymentStatus,
    required this.type,
    required this.totalPayment,
    required this.totalDiscount,
    required this.orderDetails,  
    required this.wayBills,
  });
}
