import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            padding: const EdgeInsets.all(30.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(Icons.account_circle, size: 100)),
        Container(
          padding: const EdgeInsets.all(5.0),
          alignment: Alignment.center,
          child: const Text('Patient Name/ Number'),
        ),
        Container(
          padding: const EdgeInsets.all(10.0),
          alignment: Alignment.center,
          child: const Text('Status'),
        ),
      ],
    );
  }
}
