import 'package:flutter/material.dart';
import 'package:frontend/auth/user_service.dart';
import 'package:frontend/ui/home/home_screen.dart';

class LogoutUserButton extends StatelessWidget {
  final UserService userService;
  final Size screenSize;

  const LogoutUserButton(
      {super.key, required this.userService, required this.screenSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
      width: screenSize.width,
      child: OutlinedButton(
        onPressed: () {
          userService.signOut();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      const MyHomePage(title: 'Successfully logged out')),
              (Route<dynamic> route) => false);
        },
        child: const Text(
          'Logout',
        ),
      ),
    );
  }
}
