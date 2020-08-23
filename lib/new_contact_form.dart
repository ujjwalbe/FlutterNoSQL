import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'models/contact.dart';

class NewContactForm extends StatefulWidget {
  @override
  _NewContactFormState createState() => _NewContactFormState();
}

class _NewContactFormState extends State<NewContactForm> {
  final _formKey = GlobalKey<FormState>();

  String _name;
  String _age;
  final contactBox = Hive.box('contacts');
  void addContact(Contact contact) {
    contactBox.add(jsonEncode(contact));
    print(jsonEncode(contact));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(                                    
        children: <Widget>[
          Row(children: <Widget>[
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                onSaved: (value) =>  _name =value,
              ),
            ),
            SizedBox(height: 10,),
            Expanded(
              child: TextFormField(
                
                decoration: InputDecoration(labelText: 'Age'),
                onSaved: (value) {
                   
                   _age = value;
                   }
              ),
            )
          ]),
          RaisedButton(child: Text("Add Contacts"),
          onPressed: (){
            _formKey.currentState.save();
            final newContact = Contact(age: _age, name: _name, fav: false);
            addContact(newContact);
          },
          )
        ],
      ),
    );
  }
}
