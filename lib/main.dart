import 'package:flutter/material.dart';
import 'package:test_layouts/select_page.dart';

import 'map_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        backgroundColor: Colors.white,
        focusColor: Colors.blue,
        accentIconTheme: IconThemeData(color: Colors.black)
      ),
      darkTheme: ThemeData(
        backgroundColor: Colors.black,
        focusColor: Colors.white,
      ),
      home: Seleccion(),
      debugShowCheckedModeBanner: false,
    );
  }
}


