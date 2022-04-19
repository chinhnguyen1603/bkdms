import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:bkdms/models/Item.dart';


class ItemProvider with ChangeNotifier{
  List<Item> lstItem = [];

  Future<List<Item>> fetchAndSetItem(String? token, String? workspace) async {
    var url = Uri.parse('https://bkdms.herokuapp.com' +'/mobile/api/v1/product');
    try {
      final response = await http.get(url, headers: ({
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Workspace' : "$workspace",
      }));
      
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
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
      this.lstItem = loadedCategories;
      notifyListeners();
      return lstItem;
    }
    catch (error) {
      print(error);
      throw error;
    }
  }

}
