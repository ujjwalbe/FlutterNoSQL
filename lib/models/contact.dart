

import 'dart:convert';

import 'package:hive/hive.dart';

@HiveType()
class Contact{
 
  Contact({this.name, this.age, this.fav});
 String name;
  String age;
  bool fav = false;
  Contact.fromJson(Map<String, dynamic> json) 
    :name = json['name'],
    age = json['age'],
    fav = json['fav'];
   

 Map<String, dynamic> toJson() => {
   'name': name,
   'age': age,
   'fav': fav
 };
}