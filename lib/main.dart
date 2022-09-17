import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'StartPage.dart';
import 'Storage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: const Color.fromARGB(255, 2, 12, 44),
            shadowColor: const Color(0xFF001456),
            splashColor: const Color(0xFF4169e8)),
        home: StartPage());
  }
}