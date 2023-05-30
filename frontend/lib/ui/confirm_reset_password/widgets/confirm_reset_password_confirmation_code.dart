import 'package:flutter/material.dart';

class ConfirmResetPasswordCode extends StatelessWidget {
  final TextEditingController controller;

  const ConfirmResetPasswordCode({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.confirmation_num),
      title: TextFormField(
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter the confirmation code';
          }

          return null;
        },
        decoration: const InputDecoration(
          labelText: 'Confirmation Code',
        ),
      ),
    );
  }
}
