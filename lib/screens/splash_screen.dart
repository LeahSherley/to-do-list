import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_app/screens/todo.dart';
import 'package:todo_app/widgets/widgets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 10), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ToDo()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              heading("TodoMate"),
              const SizedBox(
                height: 15,
              ),
              Image.asset(
                "assets/images/splash_image-removebg-preview.png",
                height: 150,
              ),
              const SizedBox(
                height: 15,
              ),
              heading("Your Reliable Companion for Productivity"),
            ],
          ),
        ),
      ),
    );
  }
}
