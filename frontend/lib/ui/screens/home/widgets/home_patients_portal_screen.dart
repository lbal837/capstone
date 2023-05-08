import 'package:flutter/material.dart';
import 'package:frontend/auth/user_service.dart';
import 'package:frontend/domain/patient.dart';
import 'package:frontend/ui/screens/home/widgets/home_confirm_user_button.dart';
import 'package:frontend/ui/screens/home/widgets/home_login_user_button.dart';
import 'package:frontend/ui/screens/home/widgets/home_logout_user_button.dart';
import 'package:frontend/ui/screens/home/widgets/home_profile_box.dart';
import 'package:frontend/ui/screens/home/widgets/home_sign_up_user_button.dart';

class PatientPortalScreen extends StatelessWidget {
  final UserService userService;
  final List<Patient> patientList;
  final bool isLoggedIn;
  final bool isLoaded;

  const PatientPortalScreen({
    super.key,
    required this.userService,
    required this.patientList,
    required this.isLoggedIn,
    required this.isLoaded,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    if (!isLoaded) {
      return const CircularProgressIndicator();
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        for (Patient patient in patientList)
          ProfileBox(
            name: patient.fullName,
            id: patient.userId,
            picture: patient.avatarImage,
          ),
        if (!isLoggedIn) SignUpUserButton(screenSize: screenSize),
        if (!isLoggedIn) ConfirmUserButton(screenSize: screenSize),
        if (!isLoggedIn) LoginUserButton(screenSize: screenSize),
        if (isLoggedIn)
          LogoutUserButton(userService: userService, screenSize: screenSize),
      ],
    );
  }
}
