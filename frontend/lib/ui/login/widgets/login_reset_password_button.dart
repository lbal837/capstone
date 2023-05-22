import 'package:flutter/material.dart';

class LoginResetPasswordButton extends StatelessWidget {
  const LoginResetPasswordButton({
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
          Navigator.pushNamed(context, '/initiateResetPassword');
        },
        child: const Text(
          'Forgot Password',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
