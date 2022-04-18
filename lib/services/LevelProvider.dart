import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';


class LevelProvider with ChangeNotifier{
  Future<void> getLevel(String? token, String? workspace) async {
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
    }
    catch (error) {
      print(error);
      throw error;
    }
  }

}
