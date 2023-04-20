import 'package:flutter/material.dart';
import 'package:frontend/domain/user.dart';

class InputUserFullName extends StatelessWidget {
  const InputUserFullName({
    super.key,
    required User user,
  }) : _user = user;

  final User _user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.account_box),
      title: TextFormField(
        decoration: const InputDecoration(labelText: 'Name'),
        onSaved: (n) => _user.name = n,
      ),
    );
  }
}
