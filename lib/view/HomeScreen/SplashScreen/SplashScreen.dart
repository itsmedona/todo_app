import 'dart:async';

import 'package:flutter/material.dart';
import 'package:to_do_app/view/HomeScreen/HomeScreen_Widget/HomeScreen_Widget.dart';

class MySplash extends StatefulWidget {
  const MySplash({super.key});

  @override
  State<MySplash> createState() => _MySplashState();
}

class _MySplashState extends State<MySplash> {
  @override
  void initState() {
    Timer(Duration(seconds: 4), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HomeScreenWidget(
                  title: '', description: '', date: '', color: null)));
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.deepPurpleAccent,
    body: Column(
      children: [SafeArea(child: Padding(padding: 
      EdgeInsets.all(10),
      child: Container(
        height: 55,
        width: 270,
        child: Image.asset(""),
      ),
      ),
      ),
      ],
    ),
    );
  }
}
