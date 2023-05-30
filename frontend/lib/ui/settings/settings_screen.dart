import 'package:flutter/material.dart';
import 'package:frontend/auth/user_service.dart';
import 'package:frontend/ui/settings/widgets/settings_logout_user_button.dart';

class SettingsScreen extends StatelessWidget {
  final UserService userService;

  const SettingsScreen({Key? key, required this.userService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(
        children: <Widget>[
          SettingsLogoutUserButton(
            userService: userService,
            screenSize: screenSize,
          ),
        ],
      ),
    );
  }
}
