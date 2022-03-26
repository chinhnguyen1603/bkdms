import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:bkdms/models/Item.dart';


class ItemProvider with ChangeNotifier{
  List<Item> _lstItem = [];

  List<Item> get lstItem {
    return _lstItem;
  }

/*
Future<List<Item>> fetchListItem(String? token, String? workspace) async {
  print("bắt đầu get Item");
  var url = Uri.parse('https://bkdms.herokuapp.com' +'/api/v1/product');
  final response = await http.get(url, headers: ({
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'Workspace' : "$workspace",
  }));
  List<dynamic> listItem;
  print(response.statusCode);
  print(response.body);

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
}*/
  Future<List<Item>> fetchAndSetItem(String? token, String? workspace) async {
    print("bắt đầu get Item");
    var url = Uri.parse('https://bkdms.herokuapp.com' +'/api/v1/product');
    try {
      final response = await http.get(url, headers: ({
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'Workspace' : "$workspace",
    }));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      print(response.statusCode);
      print(response.body);

      final List<Item> loadedCategories = [];
      extractedData['data']['listProduct'].forEach((itemData) {
        loadedCategories.add(
          Item(
            id: itemData['id'],
            name: itemData['name'],
            productPrice: itemData['productPrice'],
            retailPrice: itemData['retailPrice'],
            countryProduce: itemData['countryProduce'],
            dateManufacture: itemData['dateManufacture'],
            expirationDate: itemData['expirationDate'],
            barcode: itemData['barcode'],
            linkImg: itemData['linkImg'],
            description: itemData['description'],
            categoryId: itemData['categoryId'],
            productlineId: itemData['productlineId'],
            units: itemData['units'],
            category: itemData['category'],
            productline: itemData['productline'],
          ),
        );
      });
      _lstItem = loadedCategories;
      notifyListeners();
      return _lstItem;
    } catch (error) {
      print(error);
      throw error;
    }
  }

}
