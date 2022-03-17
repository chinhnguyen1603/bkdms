import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:cloudinary_sdk/cloudinary_sdk.dart';  
  final cloudinary = Cloudinary(
      "975745475279556",
      "S9YIG_sABPRTmZKb0mGNTiJsAkg",
      "di6dsngnr"
    );
var publicId= 'bkdms/gqavvlhamwvsobpofqu7';
final cloudinaryImage = CloudinaryImage.fromPublicId("di6dsngnr", "bkdms/yjws4912tr7djcm4xvi6");
                    String transformedUrl = cloudinaryImage
                        .transform()
                        .width(256)
                        .thumb()
                        .generate()!;

//String transformedUrl = "https://res.cloudinary.com/di6dsngnr/image/upload/v1647419888/bkdms/gqavvlhamwvsobpofqu7.jpg";
class TestContainerItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffc4c4c4),
      appBar: AppBar(title: Text("Test"),),
      body: Center(
         child: Container(
            color: Colors.white,
            width: 160,
            height: 160,
                  child: Image.network(
                      transformedUrl,

                  )
         ),
      ),
    );
  }
}