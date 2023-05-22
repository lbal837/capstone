import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:frontend/ui/home/home_screen.dart';
import 'color_schemes.g.dart';
import 'firebase_options.dart';

import 'routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _getFCMToken();
  }

  Future<void> _getFCMToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    debugPrint('FCM Token: $fcmToken');
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LifeSavers',
      theme: ThemeData(
          fontFamily: 'Urbanist',
          useMaterial3: true,
          colorScheme: lightColorScheme),
      darkTheme: ThemeData(
          fontFamily: 'Urbanist',
          useMaterial3: true,
          colorScheme: darkColorScheme),
      routes: routes,
      home: const HomeScreen(title: 'LifeSavers'),
    );
  }
}
