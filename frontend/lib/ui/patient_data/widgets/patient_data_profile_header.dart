import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    Key? key,
    required this.name,
    required this.picture,
    required this.isConnected,
  }) : super(key: key);
  final String? name;
  final String? picture;
  final bool isConnected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(30.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: CircleAvatar(
            radius: 70, // Image radius
            backgroundImage: NetworkImage(
              picture!,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(5.0),
          alignment: Alignment.center,
          child: Text(name!),
        ),
        Container(
          padding: const EdgeInsets.all(10.0),
          alignment: Alignment.center,
          child: Text(
            isConnected ? 'Connected' : 'Disconnected',
            style: TextStyle(
              color: isConnected ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ), //i dont think we have status atm
        ),
      ],
    );
  }
}
