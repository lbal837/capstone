import 'package:flutter/material.dart';
import 'package:frontend/domain/user.dart';

class SignupUserEmail extends StatelessWidget {
  final User user;

  const SignupUserEmail({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.email),
      title: TextFormField(
        decoration: const InputDecoration(
            hintText: 'example@inspire.my', labelText: 'Email'),
        keyboardType: TextInputType.emailAddress,
        onSaved: (n) => user.email = n,
      ),
    );
  }
}
