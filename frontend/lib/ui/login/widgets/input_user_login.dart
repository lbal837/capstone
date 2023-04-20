import 'package:flutter/material.dart';
import 'package:frontend/domain/user.dart';
import 'package:frontend/ui/login/login_screen.dart';

class InputUserLogin extends StatelessWidget {
  const InputUserLogin({
    super.key,
    required this.widget,
    required User user,
  }) : _user = user;

  final LoginScreen widget;
  final User _user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.email),
      title: TextFormField(
        initialValue: widget.email,
        decoration: const InputDecoration(
            hintText: 'example@inspire.my', labelText: 'Email'),
        keyboardType: TextInputType.emailAddress,
        onSaved: (n) => _user.email = n,
      ),
    );
  }
}
