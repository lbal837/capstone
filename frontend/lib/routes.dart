import 'package:flutter/material.dart';
import 'package:frontend/auth/user_service.dart';
import 'package:frontend/ui/add_patient/add_patient_screen.dart';
import 'package:frontend/ui/confirm_reset_password/confirm_reset_password_screen.dart';
import 'package:frontend/ui/confirmation/confirmation_screen.dart';
import 'package:frontend/ui/home/home_screen.dart';
import 'package:frontend/ui/initiate_reset_password/initiate_reset_password_screen.dart';
import 'package:frontend/ui/login/login_screen.dart';
import 'package:frontend/ui/map/map_screen.dart';
import 'package:frontend/ui/patient_data/patient_data_screen.dart';
import 'package:frontend/ui/patients_portal/patients_portal_screen.dart';
import 'package:frontend/ui/settings/settings_screen.dart';
import 'package:frontend/ui/signup/signup_screen.dart';

final Map<String, WidgetBuilder> routes = {
  '/addPatient': (context) => const AddPatientScreen(),
  '/confirmResetPassword': (context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String email = arguments['email'] as String;
    final UserService userService = arguments['userService'] as UserService;

    return ConfirmResetPasswordScreen(
      email: email,
      userService: userService,
    );
  },
  '/patientLocation': (context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final double longitude = arguments['longitude'] as double;
    final double latitude = arguments['latitude'] as double;

    return MapScreen(
      longitude: longitude,
      latitude: latitude,
    );
  },
  '/confirmAccount': (context) => const ConfirmationScreen(),
  '/home': (context) => const HomeScreen(),
  '/initiateResetPassword': (context) => const InitiateResetPasswordScreen(),
  '/login': (context) => const LoginScreen(),
  '/signup': (context) => const SignUpScreen(),
  '/patientData': (context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String patientId = arguments['userId'] as String;

    return PatientDataScreen(
      patientId: patientId,
    );
  },
  '/patientsPortal': (context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final UserService userService = arguments['userService'] as UserService;
    final bool isLoggedIn = arguments['isLoggedIn'] as bool;
    final bool isLoaded = arguments['isLoaded'] as bool;

    return PatientsPortalScreen(
      userService: userService,
      isLoggedIn: isLoggedIn,
      isLoaded: isLoaded,
    );
  },
  '/settings': (context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final UserService userService = arguments['userService'] as UserService;

    return SettingsScreen(
      userService: userService,
    );
  },
};

Route<dynamic>? onGenerateRoutes(RouteSettings settings) {
  final String? name = settings.name;
  final WidgetBuilder? builder = routes[name];

  if (builder != null) {
    return MaterialPageRoute<dynamic>(
      builder: builder,
      settings: settings,
    );
  }

  if (settings.name == '/settings') {
    final Map<String, dynamic> arguments =
        settings.arguments as Map<String, dynamic>;
    final UserService userService = arguments['userService'] as UserService;

    return MaterialPageRoute(
      builder: (_) => SettingsScreen(userService: userService),
    );
  }
  return null;
}
