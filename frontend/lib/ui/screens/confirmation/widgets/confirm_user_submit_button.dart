import 'package:flutter/material.dart';

class ConfirmUserSubmitButton extends StatelessWidget {
  const ConfirmUserSubmitButton({Key? key, required this.onPressed})
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
      child: ElevatedButton(
        onPressed: onPressed,
        child: const Text(
          'Submit',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
