import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
class Province {
    late int id;
    late String name;
    Province({
     required this.id, 
     required this.name, 
   });
}

class District{
    late int id;
    late String name;
    District({
     required this.id, 
     required this.name, 
   });
}

class Ward{
    late String name;
    Ward({
     required this.name, 
   });
}

class ProvinceProvider with ChangeNotifier{
  List<Province> lstProvince = [];
  List<District> lstDistrict = [];
  List<Ward> lstWard = [];

    
  Future<void> getProvince() async {
    final url = Uri.parse('https://dev-online-gateway.ghn.vn/shiip/public-api/master-data/province');
    print("bắt đầu get province");

      final response = await http.get(
        url, 
        headers: ({
          'Content-Type': 'application/json; charset=UTF-8',
          'Token': '3145a17c-b35a-11ec-ac64-422c37c6de1b' 
        }),
      );
      print(response.statusCode);
      // thành công
      if (response.statusCode == 200) {
        final extractedData = json.decode(response.body);
        final List<Province> loadedProvince = [];
        extractedData['data'].forEach((data) {
          loadedProvince.add(
            Province(
              id: data['ProvinceID'],
              name: data['ProvinceName']
            ),
          );
        });
        this.lstProvince = loadedProvince;
        notifyListeners();
      } 
      else{
        throw jsonDecode(response.body);
      } 
    }

  Future<void> getDistrict(int provinceId) async {
    var params = {
     "province_id": "$provinceId",
    };
    Uri uri = Uri.parse('https://dev-online-gateway.ghn.vn/shiip/public-api/master-data/district');
    final url = uri.replace(queryParameters: params);
    print("bắt đầu get district");
      final response = await http.get(
        url, 
        headers: ({
          'Content-Type': 'application/json; charset=UTF-8',
          'Token': '3145a17c-b35a-11ec-ac64-422c37c6de1b',
        }),
      );
      print(response.statusCode);
      // thành công
      if (response.statusCode == 200) {
        final extractedData = json.decode(response.body);
        final List<District> loadedDistrict = [];
        extractedData['data'].forEach((data) {
          loadedDistrict.add(
            District(
              id: data['DistrictID'],
              name: data['DistrictName']
            ),
          );
        });
        this.lstDistrict = loadedDistrict;
        notifyListeners();
      } 
      else{
        throw jsonDecode(response.body);
      } 
    }
 
  Future<void> getWard(int district_id) async {
    var params = {
     "district_id": "$district_id",
    };
    Uri uri = Uri.parse('https://dev-online-gateway.ghn.vn/shiip/public-api/master-data/ward');
    final url = uri.replace(queryParameters: params);
    print("bắt đầu get ward");
      final response = await http.get(
        url, 
        headers: ({
          'Content-Type': 'application/json; charset=UTF-8',
          'Token': '3145a17c-b35a-11ec-ac64-422c37c6de1b',
        }),
      );
      print(response.statusCode);
      // thành công
      if (response.statusCode == 200) {
        final extractedData = json.decode(response.body);
        final List<Ward> loadedWard = [];
        extractedData['data'].forEach((data) {
          loadedWard.add(
            Ward(
              name: data['WardName']
            ),
          );
        });
        this.lstWard = loadedWard;
        notifyListeners();
      } 
      else{
        throw jsonDecode(response.body);
      } 
    }
 
}