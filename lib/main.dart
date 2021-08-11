import 'package:flutter/material.dart';
import 'package:gitkaktus/app/views/home/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      title: 'GitKaktus',
      debugShowCheckedModeBanner: false,
    );
  }
}


