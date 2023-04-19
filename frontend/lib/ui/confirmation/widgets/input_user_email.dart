import 'package:flutter/material.dart';
import 'package:frontend/domain/user.dart';
import 'package:frontend/ui/confirmation/confirmation_screen.dart';

class InputUserEmail extends StatelessWidget {
  const InputUserEmail({
    super.key,
    required this.widget,
    required User user,
  }) : _user = user;

  final ConfirmationScreen widget;
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
        onSaved: (n) => _user.email = n ?? '',
      ),
    );
  }
}