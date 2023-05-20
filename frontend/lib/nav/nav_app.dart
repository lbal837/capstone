import 'package:flutter/material.dart';
import 'package:frontend/auth/user_service.dart';
import 'package:frontend/nav/bottom_nav.dart';
import 'package:frontend/nav/tab_item.dart';
import 'package:frontend/secrets.dart';
import 'package:frontend/ui/patients_portal/patients_portal_screen.dart';

class NavApp extends StatefulWidget {
  final UserService userService;
  final bool isLoggedIn;
  const NavApp({
    Key? key,
    required this.userService,
    required this.isLoggedIn,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => ScreenState();
}

class ScreenState extends State<NavApp> {
  var _currentTab = TabItem.home;

  void _selectTab(TabItem tabItem) {
    setState(() => _currentTab = tabItem);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Text("I'm hit!"),
      // body: PatientPortalScreen(
      //   userService: widget.userService,
      //   isLoggedIn: widget.isLoggedIn,
      // ),
      bottomNavigationBar: BottomNavigation(
        currentTab: _currentTab,
        onSelectTab: _selectTab,
      ),
    );
  }
}
