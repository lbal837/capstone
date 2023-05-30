import 'package:flutter/material.dart';
import 'package:frontend/auth/user_service.dart';

class SettingsLogoutUserButton extends StatelessWidget {
  final UserService userService;
  final Size screenSize;

  const SettingsLogoutUserButton({
    super.key,
    required this.userService,
    required this.screenSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
      width: screenSize.width,
      child: OutlinedButton(
        onPressed: () {
          userService.signOut();
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/home',
            (Route<dynamic> route) => false,
          );
        },
        child: const Text(
          'Logout',
        ),
      ),
    );
  }
}
