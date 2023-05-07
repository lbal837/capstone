import 'package:flutter/material.dart';
import 'package:frontend/domain/user.dart';

class SignupUserPassword extends StatelessWidget {
  const SignupUserPassword({
    super.key,
    required User user,
  }) : _user = user;

  final User _user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.lock),
      title: TextFormField(
        decoration: const InputDecoration(
          hintText: 'Password!',
        ),
        obscureText: true,
        onSaved: (n) => _user.password = n,
      ),
    );
  }
}
