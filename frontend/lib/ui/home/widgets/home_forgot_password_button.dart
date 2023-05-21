import 'package:flutter/material.dart';
import 'package:frontend/ui/initiate_forgot_password/initiate_forgot_password_screen.dart';

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({
    super.key,
    required this.screenSize,
  });

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
      width: screenSize.width,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const InitiateForgotPasswordScreen()),
          );
        },
        child: const Text(
          'Forgot Password',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
