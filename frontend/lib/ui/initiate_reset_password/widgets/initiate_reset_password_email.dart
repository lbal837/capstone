import 'package:flutter/material.dart';

class InitiateResetPasswordEmail extends StatelessWidget {
  const InitiateResetPasswordEmail({
    super.key,
    required TextEditingController emailController,
  }) : _emailController = emailController;

  final TextEditingController _emailController;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.email),
      title: TextFormField(
        controller: _emailController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your email';
          }

          return null;
        },
        decoration: const InputDecoration(
          hintText: 'example@inspire.my',
          labelText: 'Email',
        ),
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }
}
