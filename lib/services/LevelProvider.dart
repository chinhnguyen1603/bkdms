import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:bkdms/models/Level.dart';


class LevelProvider with ChangeNotifier{
  List<Level> lstLevel =[];


  //get hạn mức
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
      if (response.statusCode == 200){
         final extractedData = json.decode(response.body) as Map<String, dynamic>;
         final List<Level> loadListLevel = [];
         extractedData['data']['listLevel'].forEach((levelData) {
         loadListLevel.add(
          Level(
            id:  levelData['id'],
            name: levelData['name'],
            discountRange: levelData['discountRange'],
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
  Future<void> registerLevel(String? token, String? workspace, String levelId, String agencyId) async {
    print("bắt đầu get level");
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
      print(response.body);
    }
    catch (error) {
      print(error);
      throw error;
    }
  }


}
