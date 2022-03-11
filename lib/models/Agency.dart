
import 'package:flutter/cupertino.dart';

class Agency with ChangeNotifier {
  late int? id;
  late String? name;
  late String? nameOwn;
  late String? phone;
  late String? dateJoin;
  late String? province;
  late String? district;
  late String? ward;
  late String? extraInfoOfAddress;
  late String? password; 
  late String? workspace;
  late String? paymentType;
  late String? maxDebt;
  late String? maxDebtPeriod;

  Agency({
     this.id,
     this.name,
     this.nameOwn,
     this.phone, 
     this.dateJoin,
     this.province,
     this.district,
     this.ward,
     this.extraInfoOfAddress,
     this.password,
     this.workspace,
     this.paymentType,
     this.maxDebt,
     this.maxDebtPeriod,
  });
  
  void updateValue (Agency newAgency){
     this.id = newAgency.id;
     this.name = newAgency.name;
     this.nameOwn = newAgency.nameOwn;
     this.phone = newAgency.phone;
     this.dateJoin = newAgency.dateJoin;
     this.province = newAgency.province;
     this.district = newAgency.district;
     this.ward = newAgency.ward;
     this.extraInfoOfAddress = newAgency.extraInfoOfAddress;
     this.password = newAgency.password;
     this.workspace = newAgency.workspace;
     this.paymentType = newAgency.paymentType;
     this.maxDebt = newAgency.maxDebt;
     this.maxDebtPeriod = newAgency.maxDebtPeriod;
    notifyListeners();

  }

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