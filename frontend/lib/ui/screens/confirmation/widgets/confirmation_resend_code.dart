import 'package:flutter/material.dart';

class ConfirmationResendCode extends StatelessWidget {
  const ConfirmationResendCode({Key? key, required this.onTap})
      : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onTap,
        child: const Text(
          'Resend Confirmation Code',
          style: TextStyle(color: Colors.blueAccent),
        ),
      ),
    );
  }
}
