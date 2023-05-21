import 'package:flutter/material.dart';

class ConfirmResetPasswordNewPassword extends StatelessWidget {
  final TextEditingController controller;

  const ConfirmResetPasswordNewPassword({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.lock),
      title: TextFormField(
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your new password';
          }
          return null;
        },
        decoration: const InputDecoration(
          labelText: 'New Password',
        ),
        obscureText: true,
      ),
    );
  }
}
