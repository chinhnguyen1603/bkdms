import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class TestTime extends StatelessWidget {
 String partnerCode = "MOMOAWA120220330";
 String partnerRefId = "12345567";
 String requestType = "capture";
 String requestId ="123282846";
 String momoTransId = "206163921";
 String secretKey= "edhBlVIaGUFzaneb6f4gHvc1MPsFHvMr";

 //
 @override
  Widget build(BuildContext context) {
    return Container(
       child: ElevatedButton(
         onPressed: (){
           var key = utf8.encode(this.secretKey);
           var data = utf8.encode("partnerCode=$partnerCode&partnerRefId=$partnerRefId&requestType=$requestType&requestId=$requestId&momoTransId=$momoTransId");
           //var data = utf8.encode("partnerCode=MOMOAWA120220330&partnerRefId=12345567&requestType=capture&requestId=123282846&momoTransId=206163921");
           var hmacSha256 = Hmac(sha256, key); 
           var signature = hmacSha256.convert(data);
           print(signature);
         },
         child: Text("Test Hmac sha256"),
       ),
    );
  }
}