import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:frontend/auth/user_service.dart';
import 'package:frontend/data/user_repository.dart';
import 'package:frontend/domain/patient.dart';
import 'package:frontend/ui/add_patient/add_patient_screen.dart';
import 'package:frontend/ui/home/widgets/home_profile_box.dart';
import 'package:frontend/ui/patients_portal/widgets/patients_portal_logout_user_button.dart';

class PatientPortalScreen extends StatefulWidget {
  final UserRepository userRepository = UserDefaultRepository();
  final UserService userService;
  final bool isLoggedIn;
  final bool isLoaded;

  PatientPortalScreen({
    Key? key,
    required this.userService,
    required this.isLoggedIn,
    required this.isLoaded,
  }) : super(key: key);

  @override
  PatientPortalScreenState createState() => PatientPortalScreenState();
}

class PatientPortalScreenState extends State<PatientPortalScreen> {
  List<Patient> patientList = [];
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    final user = await widget.userService.getCurrentUser();
    patientList = await widget.userRepository.fetchUserPatients(user!.email!);
    if (mounted) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    if (!isLoaded) {
      return const SpinKitPumpingHeart(
        color: Colors.purple,
      );
    }

    return Stack(
      children: [
        SizedBox(
          height: screenSize.height,
          width: screenSize.width,
          child: Column(
            children: <Widget>[
              for (Patient patient in patientList)
                ProfileBox(
                  name: patient.fullName,
                  id: patient.userId,
                  picture: patient.avatarImage,
                ),
              if (widget.isLoggedIn)
                PatientsPortalLogoutUserButton(
                    userService: widget.userService, screenSize: screenSize)
            ],
          ),
        ),
        Positioned(
          bottom: MediaQuery.of(context).size.height / 7,
          right: MediaQuery.of(context).size.width / 25,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddPatientScreen(),
                ),
              );
            },
            elevation: 5,
            hoverElevation: 25,
            heroTag: 'null',
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
