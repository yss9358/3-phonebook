import 'package:flutter/material.dart';
import 'solMainList.dart';
import 'solGroupList.dart';
import 'solStarList.dart';
import 'dial.dart';
import 'solGroupInList.dart';
import 'call.dart';
import 'jwread.dart';
import 'jwEditForm.dart';
import 'mWriteform.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/' : (context) => MainList(),
        '/group' : (context) => GroupList(),
        '/star' : (context) => StarList(),
        '/dial' : (context) => DialPage(),
        '/groupin' : (context) => GroupInList(),
        '/call' : (context) => CallPage(),
        '/read' : (context) => ReadPage(),
        '/editform' : (context) => EditForm(),
        '/write' : (context) => Writeform(),
      },
    );
  }
}

