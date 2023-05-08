import 'package:flutter/material.dart';
import 'package:frontend/ui/screens/home/widgets/home_confirm_user_button.dart';
import 'package:frontend/ui/screens/home/widgets/home_login_user_button.dart';
import 'package:frontend/ui/screens/home/widgets/home_sign_up_user_button.dart';

class AuthButtonsScreen extends StatelessWidget {
  final Size screenSize;

  const AuthButtonsScreen({super.key, required this.screenSize});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SignUpUserButton(screenSize: screenSize),
        ConfirmUserButton(screenSize: screenSize),
        LoginUserButton(screenSize: screenSize),
      ],
    );
  }
}
