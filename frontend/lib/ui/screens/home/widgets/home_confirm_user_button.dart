import 'package:flutter/material.dart';
import 'package:frontend/ui/screens/confirmation/confirmation_screen.dart';

class ConfirmUserButton extends StatelessWidget {
  const ConfirmUserButton({
    super.key,
    required this.screenSize,
  });

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
      width: screenSize.width,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ConfirmationScreen()),
          );
        },
        child: const Text(
          'Confirm Account',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
