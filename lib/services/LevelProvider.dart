import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:bkdms/models/Level.dart';


class LevelProvider with ChangeNotifier{
  List<Level> lstLevel =[];
  List<HistoryRegister> lstHistoryRegister =[];


  //get các loại hạn mức
  Future<void> getLevel(String token, String workspace) async {
    print("bắt đầu get level");
    var url = Uri.parse('https://bkdms.herokuapp.com' +'/mobile/api/v1/level');
    try {
      final response = await http.get(url, headers: ({
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Workspace' : "$workspace",
      }));
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200){
         final extractedData = json.decode(response.body) as Map<String, dynamic>;
         final List<Level> loadListLevel = [];
         extractedData['data']['listLevel'].forEach((levelData) {
           loadListLevel.add(
             Level(
               id:  levelData['id'],
               name: levelData['name'],
               time: levelData['time'],
               registrationConditions: levelData['registrationConditions'],
               rewardConditions: levelData['rewardConditions'],
               gifts: levelData['gifts'],  
             ),
           );
         });
         this.lstLevel = loadListLevel;
         notifyListeners();
      } else{
        throw jsonDecode(response.body.toString());
      }
    }
    catch (error) {
      print(error);
      throw error;
    }
  }

  //đăng kí hạn mức, dùng levelId + agencyId
  Future<void> registerLevel(String token, String workspace, String agencyId, String levelId) async {
    print("bắt đầu đăng kí level");
    var url = Uri.parse('https://bkdms.herokuapp.com' +'/mobile/api/v1/level/register');
    try {
      final response = await http.post(
        url, 
        headers: ({
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Workspace' : "$workspace",
        }),
        body: jsonEncode(<String, dynamic>{
          'agencyId': agencyId,
          'levelId': levelId,
        }),
      );
      print(response.statusCode);
      if(response.statusCode == 201){
         throw jsonDecode(response.body.toString());
      }
      else{
        throw jsonDecode(response.body.toString());
      }
    }
    catch (error) {
      print(error);
      throw error;
    }
  }

  //lấy level hiện tại + lịch sử level
  Future<void> getHistoryLevel(String token, String workspace, String agencyId) async {
    print("bắt đầu lấy lịch sử đăng kí level");
    var url = Uri.parse('https://bkdms.herokuapp.com' +'/mobile/api/v1/level/get-all-level-of-agency');
    try {
      final response = await http.post(
        url, 
        headers: ({
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Workspace' : "$workspace",
        }),
        body: jsonEncode(<String, dynamic>{
          'agencyId': agencyId,
        }),
      );
      print(response.statusCode);
      print(response.body);
      if(response.statusCode == 200){
         final extractedData = json.decode(response.body) as Map<String, dynamic>;
         final List<HistoryRegister> loadHistoryRegister = [];
         extractedData['data']['levelAgency'].forEach((data) {
           loadHistoryRegister.add(
             HistoryRegister(
               id: data['id'],
               createTime: data['createTime'],
               expireTime: data['expireTime'],
               cancelTime: data['cancelTime'],
               isRegistering: data['isRegistering'],
               isQualified: data['isQualified'],
               levelId: data['level']['id'],
               levelName: data['level']['name'],  
             ),
           );
         });
         this.lstHistoryRegister = loadHistoryRegister;
         notifyListeners();
      }
      else{
        throw jsonDecode(response.body.toString());
      }
    }
    catch (error) {
      print(error);
      throw error;
    }
  }

  //kiểm tra hạn mức
  Future<void> checkLevel(String token, String workspace, String agencyId, String levelId, String historyId) async {
    print("bắt đầu kiểm tra level");
    var url = Uri.parse('https://bkdms.herokuapp.com' +'/mobile/api/v1/level/check-reward-level');
    try {
      final response = await http.post(
        url, 
        headers: ({
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Workspace' : "$workspace",
        }),
        body: jsonEncode(<String, dynamic>{
          'agencyId': agencyId,
          'levelId': levelId,
          'id': historyId,
        }),
      );
      print(response.statusCode);
      if(response.statusCode == 201){
         throw jsonDecode(response.body.toString());
      }
      else{
        throw jsonDecode(response.body.toString());
      }
    }
    catch (error) {
      print(error);
      throw error;
    }
  }


}


//level/check-reward-level; agencyId, levelId, id