import 'package:flutter/material.dart';

class ConfirmUserButton extends StatelessWidget {
  const ConfirmUserButton({Key? key, required this.onPressed})
      : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.all(20.0),
      width: screenSize.width,
      margin: const EdgeInsets.only(
        top: 10.0,
      ),
      child: FilledButton(
        onPressed: onPressed,
        child: const Text(
          'Confirm email address',
        ),
      ),
    );
  }
}
