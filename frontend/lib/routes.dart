import 'package:flutter/material.dart';
import 'package:frontend/auth/user_service.dart';
import 'package:frontend/ui/add_patient/add_patient_screen.dart';
import 'package:frontend/ui/confirm_reset_password/confirm_reset_password_screen.dart';
import 'package:frontend/ui/confirmation/confirmation_screen.dart';
import 'package:frontend/ui/home/home_screen.dart';
import 'package:frontend/ui/initiate_reset_password/initiate_reset_password_screen.dart';
import 'package:frontend/ui/login/login_screen.dart';
import 'package:frontend/ui/signup/signup_screen.dart';

final Map<String, WidgetBuilder> routes = {
  '/addPatient': (context) => const AddPatientScreen(),
  // '/confirmResetPassword':(context) => const ConfirmResetPasswordScreen(),
  '/confirmAccount': (context) => const ConfirmationScreen(),
  '/home':(context) => const HomeScreen(),
  '/initiateResetPassword':(context) => const InitiateResetPasswordScreen(),
  '/login':(context) => const LoginScreen(),
  // '/patientData':(context) => const PatientDataScreen(),
  // '/patientsPortal': (context) => PatientPortalScreen(),
  '/signup':(context) => const SignUpScreen(),
};

Route<dynamic>? onGenerateRoutes(RouteSettings settings) {
  final String? name = settings.name;
  final WidgetBuilder? builder = routes[name];

  if (builder != null) {
    return MaterialPageRoute<dynamic>(
      builder: (context) {
        if (name == '/confirmResetPassword') {
          final Map<String, dynamic> arguments = settings.arguments as Map<String, dynamic>;
          final String email = arguments['email'] as String;
          final UserService userService = arguments['userService'] as UserService;

          return ConfirmResetPasswordScreen(
            email: email,
            userService: userService,
          );
        }

        return builder(context);
      },
      settings: settings,
    );
  }

  return null;
}
