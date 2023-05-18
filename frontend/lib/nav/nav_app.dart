import 'package:flutter/material.dart';
import 'package:frontend/auth/user_service.dart';
import 'package:frontend/nav/tab_item.dart';
import 'package:frontend/secrets.dart';
import 'package:frontend/ui/patients_portal/patients_portal_screen.dart';

import '../ui/home/home_screen.dart';
import 'bottom_nav.dart';

class NavApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ScreenState();
}

class ScreenState extends State<NavApp> {
  var _currentTab = TabItem.home;
  final UserService userService = UserService(userPool);
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    isLoggedIn = userService.isLoggedIn() as bool;
  }

  void _selectTab(TabItem tabItem) {
    setState(() => _currentTab = tabItem);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PatientPortalScreen(
          userService: userService,
          patientList: [],
          isLoggedIn: isLoggedIn,
          isLoaded: true),
      bottomNavigationBar: BottomNavigation(
        currentTab: _currentTab,
        onSelectTab: _selectTab,
      ),
    );
  }
}
