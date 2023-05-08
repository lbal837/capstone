import 'package:flutter/material.dart';
import 'package:frontend/auth/user_service.dart';
import 'package:frontend/domain/patient.dart';
import 'package:frontend/ui/add_patient/add_patient_screen.dart';
import 'package:frontend/ui/home/widgets/home_profile_box.dart';
import 'package:frontend/ui/patients_portal/widgets/patients_portal_logout_user_button.dart';
import 'package:frontend/ui/patients_portal/widgets/patients_portal_sns_endpoint_creator.dart';

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
        if (isLoggedIn)
          LogoutUserButton(userService: userService, screenSize: screenSize),
        FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddPatientScreen(),
                ));
          },
          elevation: 5,
          hoverElevation: 25,
          splashColor: Colors.purple,
          backgroundColor: Colors.deepPurple,
          heroTag: 'uniqueTag',
          child: const Icon(Icons.add),
        ),
      ],
    );
  }
}
