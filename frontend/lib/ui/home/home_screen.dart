import 'package:flutter/material.dart';
import 'package:frontend/auth/user_service.dart';
import 'package:frontend/data/user_repository.dart';
import 'package:frontend/domain/patient.dart';
import 'package:frontend/nav/nav_app.dart';
import 'package:frontend/secrets.dart';
import 'package:frontend/ui/home/widgets/home_confirm_user_button.dart';
import 'package:frontend/ui/home/widgets/home_login_user_button.dart';
import 'package:frontend/ui/home/widgets/home_sign_up_user_button.dart';
import 'package:frontend/ui/patients_portal/patients_portal_screen.dart';

import 'widgets/home_forgot_password_button.dart';

class _MyHomePageState extends State<MyHomePage> {
  final userService = UserService(userPool);
  final userRepository = UserDefaultRepository();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: [
          FutureBuilder<bool>(
            future: userService.isLoggedIn(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              final bool isLoggedIn = snapshot.data ?? false;
              debugPrint(isLoggedIn.toString());

              if (isLoggedIn) {
                debugPrint("I'm logged in!");
                return NavApp(
                  isLoggedIn: isLoggedIn,
                  userService: userService,
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SignUpUserButton(screenSize: screenSize),
                    ConfirmUserButton(screenSize: screenSize),
                    LoginUserButton(screenSize: screenSize),
                    ForgotPasswordButton(screenSize: screenSize),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
