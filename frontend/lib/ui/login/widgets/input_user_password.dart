import 'package:flutter/material.dart';
import 'package:frontend/domain/user.dart';

class InputUserPassword extends StatelessWidget {
  const InputUserPassword({
    super.key,
    required User user,
  }) : _user = user;

  final User _user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.lock),
      title: TextFormField(
        decoration: const InputDecoration(labelText: 'Password'),
        obscureText: true,
        onSaved: (n) => _user.password = n,
      ),
    );
  }
}
