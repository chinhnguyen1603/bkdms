import 'package:flutter/cupertino.dart';

class Album with ChangeNotifier{
  late int? userId;
  late int? id;
  late String? title;

  Album({
    this.userId,
    this.id,
    this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}