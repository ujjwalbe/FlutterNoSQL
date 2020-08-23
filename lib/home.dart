import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_test/models/contact.dart';

import 'new_contact_form.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final contactsBox = Hive.box('contacts');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hive Test')),
      body: Column(
        children: <Widget>[
          Expanded(
            child: _buildListView(),
          ),
          //FlatBut(),
          NewContactForm()
        ],
        
      ),
    );
  }
}

Widget _buildListView() {
  final contactsBox = Hive.box('contacts');
  return ValueListenableBuilder(valueListenable: Hive.box('contacts').listenable(), builder: (context, contactBox, _){
return ListView.builder(
    itemCount: contactsBox.length,
    itemBuilder: (context, index){
      final  contactData = contactsBox.getAt(index);
      print(contactData.runtimeType);
      Map contactMap = jsonDecode(contactData);
      final contact = Contact.fromJson(contactMap);
      print(contact.age);
      return ListTile(
        
        leading: IconButton(icon: Icon(Icons.favorite, color: contact.fav ? Colors.red : Colors.grey,), onPressed: (){
          Contact update = Contact(fav: contact.fav ? false: true , age: contact.age, name: contact.name);
          contactsBox.putAt(index, jsonEncode(update));
        }, ),
        title: Text(contact.name),
        subtitle: Text(contact.age.toString()),
        trailing: IconButton(icon: Icon(Icons.delete), onPressed: (){
          contactsBox.deleteAt(index);
        }),
      );
    }
  );
  });
}

Widget FlatBut(){
  final box = Hive.box('contacts');
  return FlatButton(
    child: Row(children: [Icon(Icons.delete, size: 50.0,)],),
    onPressed: (){
      for(int i = 0;box.length >=0 ; i-- ){
        box.deleteAt(i);
        if(box.length == null){
          break;
        }
      }
  });
}