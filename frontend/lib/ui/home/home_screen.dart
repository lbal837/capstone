import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:frontend/auth/user_service.dart';
import 'package:frontend/data/user_repository.dart';
import 'package:frontend/domain/patient.dart';
import 'package:frontend/secrets.dart';
import 'package:frontend/ui/home/widgets/home_confirm_user_button.dart';
import 'package:frontend/ui/home/widgets/home_forgot_password_button.dart';
import 'package:frontend/ui/home/widgets/home_login_user_button.dart';
import 'package:frontend/ui/home/widgets/home_sign_up_user_button.dart';
import 'package:frontend/ui/patients_portal/patients_portal_screen.dart';

class _MyHomePageState extends State<MyHomePage> {
  final userService = UserService(userPool);
  final userRepository = UserDefaultRepository();
  List<Patient> patientList = [];
  bool isLoaded = false;

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
                return const Center(
                  child: SpinKitDoubleBounce(
                    color: Colors.purple,
                  ),
                );
              }
              final bool isLoggedIn = snapshot.data ?? false;
              debugPrint(isLoggedIn.toString());

              if (isLoggedIn) {
                return PatientPortalScreen(
                  isLoggedIn: isLoggedIn,
                  isLoaded: isLoaded,
                  userService: userService,
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(80.0),
                          child: Image.asset(
                            'assets/images/icon.png',
                            width: 160,
                            height: 160,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'LifeSavers',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Urbanist',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    LoginUserButton(screenSize: screenSize),
                    const SizedBox(
                      height: 50,
                    ),
                    const SizedBox(
                      height: 40,
                      child: Text('New User? Sign up below'),
                    ),
                    SignUpUserButton(screenSize: screenSize),
                    ConfirmUserButton(screenSize: screenSize),
                    ForgotPasswordButton(screenSize: screenSize),
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
