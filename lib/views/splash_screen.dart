import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news_app/views/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Center(
        child: SizedBox(
          width: width * 0.6,
          height: height * 0.6,
          child: Image.asset(
            "assets/images/news.png",
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
