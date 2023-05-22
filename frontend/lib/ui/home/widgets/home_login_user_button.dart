import 'package:flutter/material.dart';
import 'package:frontend/ui/login/login_screen.dart';

class LoginUserButton extends StatelessWidget {
  const LoginUserButton({
    super.key,
    required this.screenSize,
  });

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
      width: screenSize.width,
      child: FilledButton(
        onPressed: () {
          Navigator.pushNamed(context, '/login');
        },
        child: const Text(
          'Login',
        ),
      ),
    );
  }
}
