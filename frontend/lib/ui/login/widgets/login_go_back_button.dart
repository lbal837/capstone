import 'package:flutter/material.dart';

class LoginGoBackButton extends StatelessWidget {
  final VoidCallback onPressed;

  const LoginGoBackButton({Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
      child: TextButton(
        onPressed: onPressed,
        child: const Text(
          'Go Back',
        ),
      ),
    );
  }
}
