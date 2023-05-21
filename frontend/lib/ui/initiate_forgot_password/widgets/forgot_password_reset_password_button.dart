import 'package:flutter/material.dart';

class ResetPasswordButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ResetPasswordButton({Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(20.0),
      width: screenSize.width,
      margin: const EdgeInsets.only(
        top: 10.0,
      ),
      child: FilledButton(
        onPressed: onPressed,
        child: const Text('Reset Password'),
      ),
    );
  }
}
