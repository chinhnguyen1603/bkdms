
import 'package:flutter/cupertino.dart';

class Agency with ChangeNotifier {
  final int id;
  final String name;
  final String nameOwn;
  final String phone;
  final String dateJoin;
  final String province;
  final String district;
  final String ward;
  final String extraInfoOfAddress;
  final String password; 
  final String workspace;
  final String paymentType;
  final String maxDebt;
  final String maxDebtPeriod;

  Agency({
    required this.id,
    required this.name,
    required this.nameOwn,
    required this.phone, 
    required this.dateJoin,
    required this.province,
    required this.district,
    required this.ward,
    required this.extraInfoOfAddress,
    required this.password,
    required this.workspace,
    required this.paymentType,
    required this.maxDebt,
    required this.maxDebtPeriod,
  });
  notifyListeners();

  factory Agency.fromJson(Map<String, dynamic> json) {
    return Agency(
      id: json['data']['user']['id'] as int,
      name: json['data']['user']['name'] as String,
      nameOwn: json['data']['user']['nameOwn'] as String,
      phone: json['data']['user']['phone'] as String,
      dateJoin: json['data']['user']['dateJoin'] as String,
      province:  json['data']['user']['province'] as String,
      district:  json['data']['user']['district'] as String,
      ward:  json['data']['user']['ward'] as String,
      extraInfoOfAddress:  json['data']['user']['extraInfoOfAddress'] as String,
      password: json['data']['user']['password'] as String,
      workspace: json['data']['user']['workspace'] as String,
      paymentType:  json['data']['user']['paymentType'] as String,
      maxDebt:  json['data']['user']['maxDebt'] as String,
      maxDebtPeriod:  json['data']['user']['maxDebtPeriod'] as String,
      
    );
    
  }
}