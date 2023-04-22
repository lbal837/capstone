import 'package:flutter/material.dart';
import 'package:frontend/auth/user_service.dart';
import 'package:frontend/secrets.dart';
import 'package:frontend/ui/home/widgets/home_confirm_user_button.dart';
import 'package:frontend/ui/home/widgets/home_login_user_button.dart';
import 'package:frontend/ui/home/widgets/home_profile_box.dart';
import 'package:frontend/ui/home/widgets/home_sign_up_user_button.dart';

class _MyHomePageState extends State<MyHomePage> {
  final userService = UserService(userPool);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder<bool>(
          future: userService.isLoggedIn(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            final bool isLoggedIn = snapshot.data ?? false;
            debugPrint(isLoggedIn.toString());
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const ProfileBox(),
                const ProfileBox(),
                SignUpUserButton(screenSize: screenSize),
                ConfirmUserButton(screenSize: screenSize),
                if (!isLoggedIn) LoginUserButton(screenSize: screenSize),
              ],
            );
          },
        ),
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
