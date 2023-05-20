import 'package:flutter/material.dart';
import 'package:frontend/auth/user_service.dart';
import 'package:frontend/data/patient_repository.dart';
import 'package:frontend/domain/patient.dart';
import 'package:frontend/secrets.dart';
import 'package:frontend/ui/home/widgets/home_confirm_user_button.dart';
import 'package:frontend/ui/home/widgets/home_login_user_button.dart';
import 'package:frontend/ui/home/widgets/home_sign_up_user_button.dart';
import 'package:frontend/ui/patients_portal/patients_portal_screen.dart';

class _MyHomePageState extends State<MyHomePage> {
  final userService = UserService(userPool);
  List<Patient> patientList = [];
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    final PatientDefaultRepository patientRepository =
        PatientDefaultRepository();
    patientList = await patientRepository.fetchAllPatients();
    if (patientList.isNotEmpty) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: [
          FutureBuilder<bool>(
            future: userService.isLoggedIn(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              final bool isLoggedIn = snapshot.data ?? false;
              debugPrint(isLoggedIn.toString());

              if (isLoggedIn) {
                return PatientPortalScreen(
                  userService: userService,
                  patientList: patientList,
                  isLoggedIn: isLoggedIn,
                  isLoaded: isLoaded,
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SignUpUserButton(screenSize: screenSize),
                    ConfirmUserButton(screenSize: screenSize),
                    LoginUserButton(screenSize: screenSize),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
