import 'package:flutter/material.dart';
import 'package:flutter_application_1/HomePage.dart';
import 'dart:async';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/5470208.jpg"), fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "S",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 60,
                              color: Colors.orange),
                        ),
                        Text(
                          "T",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 60,
                          ),
                        ),
                        Text(
                          "O",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 60,
                              color: Colors.orange),
                        ),
                        Text(
                          "R",
                          style:
                              TextStyle(fontWeight: FontWeight.bold, fontSize: 60),
                        ),
                        Text(
                          "A",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 60,
                              color: Colors.orange),
                        ),
                        Text(
                          "G",
                          style:
                              TextStyle(fontWeight: FontWeight.bold, fontSize: 60),
                        ),
                        Text(
                          "E",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 60,
                              color: Colors.orange),
                        ),
                      ],
                    ),
          Text("Made By Muneer Zaatreh",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
          ],
        ),
    ));
  }
}
