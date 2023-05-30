import 'package:flutter/material.dart';
import 'package:frontend/auth/user_service.dart';
import 'package:frontend/ui/add_patient/add_patient_screen.dart';
import 'package:frontend/ui/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:frontend/ui/patients_portal/patients_portal_screen.dart';
import 'package:frontend/ui/settings/settings_screen.dart';

class MainScreen extends StatefulWidget {
  final UserService userService;
  final bool isLoaded;

  const MainScreen({
    Key? key,
    required this.userService,
    required this.isLoaded,
  }) : super(key: key);

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  final ValueNotifier<int> _selectedIndex = ValueNotifier<int>(0);

  List<Widget> get _widgetOptions {
    return <Widget>[
      PatientsPortalScreen(
        userService: widget.userService,
        isLoaded: widget.isLoaded,
      ),
      const AddPatientScreen(),
      SettingsScreen(userService: widget.userService),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex.value = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex.value),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex.value,
        onItemSelected: _onItemTapped,
      ),
    );
  }
}
