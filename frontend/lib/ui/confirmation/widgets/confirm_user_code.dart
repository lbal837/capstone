import 'package:flutter/material.dart';

class ConfirmUserCode extends StatelessWidget {
  const ConfirmUserCode(
      {Key? key, required this.confirmationCode, required this.onSaved,})
      : super(key: key);

  final String confirmationCode;
  final Function(String?) onSaved;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.lock),
      title: TextFormField(
        decoration: const InputDecoration(
          labelText: 'Confirmation Code',
        ),
        onSaved: onSaved,
      ),
    );
  }
}
