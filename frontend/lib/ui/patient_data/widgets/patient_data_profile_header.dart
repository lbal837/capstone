import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({Key? key, required this.name}) : super(key: key);
  final String? name;

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
          child: Text(name!),
        ),
        Container(
          padding: const EdgeInsets.all(10.0),
          alignment: Alignment.center,
          child:
              const Text('[insert status]'), //i dont think we have status atm
        ),
      ],
    );
  }
}
