import 'package:flutter/material.dart';

class ConfirmResendCode extends StatelessWidget {
  const ConfirmResendCode({Key? key, required this.onTap})
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
