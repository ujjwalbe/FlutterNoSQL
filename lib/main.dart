import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_test/home.dart';
import 'package:path_provider/path_provider.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final path = await getApplicationDocumentsDirectory();
  print(path);
  Hive.init(path.path);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        future: Hive.openBox('contacts'),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.hasError){
              return Text(snapshot.error.toString());
            }
            else
              return HomePage();
          }else{
            return Scaffold(appBar: AppBar(title: Text('Test'),),);
          }
          
        },
      ),
    );
    
  }
  
}
