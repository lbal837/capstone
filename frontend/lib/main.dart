import 'package:flutter/material.dart';
import 'package:frontend/secrets.dart';
import 'package:frontend/ui/confirmation/confirmation_screen.dart';
import 'package:frontend/ui/login/login_screen.dart';
import 'package:frontend/ui/signup/signup_screen.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/ui/home/home.dart';

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
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: 'LifeSavers'),
    );
  }
}
