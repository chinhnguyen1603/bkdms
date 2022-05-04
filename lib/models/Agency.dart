
import 'package:flutter/cupertino.dart';

class Agency with ChangeNotifier{
  late String id;
  late String name;
  late String nameOwn;
  late String phone;
  late String dateJoin;
  late String province;
  late String district;
  late String ward;
  late String extraInfoOfAddress;
  late String workspace;
  late String? maxDebt;
  late String? maxDebtPeriod;
  late String currentTotalDebt;
  late String? debtStartTime;
  late String token;

  Agency();
  Agency.getApi({
     required this.id,
     required this.name,
     required this.nameOwn,
     required this.phone, 
     required this.dateJoin,
     required this.province,
     required this.district,
     required this.ward,
     required this.extraInfoOfAddress,
     required this.workspace,
     this.maxDebt,
     this.maxDebtPeriod,
     required this.currentTotalDebt,
     required this.debtStartTime,
     required this.token,
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
     this.workspace = newAgency.workspace;
     this.maxDebt = newAgency.maxDebt;
     this.maxDebtPeriod = newAgency.maxDebtPeriod;
     this.currentTotalDebt = newAgency.currentTotalDebt;
     this.debtStartTime = newAgency.debtStartTime;
     this.token = newAgency.token;
    notifyListeners();

  }

  factory Agency.fromJson(Map<String, dynamic> json) {
    return Agency.getApi(
      id: json['data']['user']['id'],
      name: json['data']['user']['name'],
      nameOwn: json['data']['user']['nameOwn'],
      phone: json['data']['user']['phone'],
      dateJoin: json['data']['user']['dateJoin'],
      province:  json['data']['user']['province'],
      district:  json['data']['user']['district'],
      ward:  json['data']['user']['ward'],
      extraInfoOfAddress:  json['data']['user']['extraInfoOfAddress'],
      workspace: json['data']['user']['workspace'],
      maxDebt:  json['data']['user']['maxDebt'],
      maxDebtPeriod:  json['data']['user']['maxDebtPeriod'],
      currentTotalDebt: json['data']['user']['currentTotalDebt'],
      debtStartTime: json['data']['user']['debtStartTime'],
      token: json['data']['jwtToken'],    
    );
    
  }
}