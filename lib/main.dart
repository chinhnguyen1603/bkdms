import 'package:bkdms/screens/home_screens/DetailItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bkdms/models/Agency.dart';
import 'package:bkdms/models/Item.dart';
import 'package:bkdms/screens/home_screens/HomePage.dart';
import 'package:bkdms/screens/home_screens/Login.dart';
import 'splash_screen.dart';
import 'package:bkdms/services/ItemProvider.dart';
import 'package:bkdms/models/CountBadge.dart';
import 'package:bkdms/services/CartProvider.dart';
import 'package:bkdms/screens/home_screens/ScreenCart.dart';
import 'package:bkdms/services/ProvinceProvider.dart';






void main() => runApp( MyApp());


class MyApp extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
   return MultiProvider(
    providers: [
        ChangeNotifierProvider(create: (context) => Agency()),
        ChangeNotifierProvider(create: (context) => ItemProvider()),
        ChangeNotifierProvider(create: (context) => CountBadge()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => ProvinceProvider()),
    ],
    child: MaterialApp(
      title: "BKDMS Mobile App",
      
      home: Scaffold(
        backgroundColor: Color(0xffF4F4F4),
        body: ScreenCart(),
        ),
      )
    );
  }
}


