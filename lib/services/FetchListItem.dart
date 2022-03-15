import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:bkdms/models/Item.dart';




Future<List<dynamic>> fetchListItem(String? token, String? workspace) async {
  print("bắt đầu get album");
  var url = Uri.parse('https://bkdms.herokuapp.com' +'/api/v1/product');
  final response = await http.get(url, headers: ({
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'Workspace' : "$workspace",
  }));
  List<dynamic> listItem;
  

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    
   listItem = jsonDecode(response.body)['data']['listProduct']
      .map((data) => Item.fromJson(data))
      .toList();
    print(listItem[0].productPrice);
    return listItem; 
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to fetch item');
  }
}


