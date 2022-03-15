import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:bkdms/models/Item.dart';




Future<Item> fetchListItem(String? token, String? workspace) async {
  print("bắt đầu get album");
  var url = Uri.parse('https://bkdms.herokuapp.com' +'/api/v1/product');
  final response = await http.get(url, headers: ({
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'Workspace' : "$workspace",
  }));

  

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(response.body);
    return Item.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to fetch item');
  }
}


