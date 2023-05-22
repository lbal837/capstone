import 'package:flutter/material.dart';
import 'package:frontend/ui/add_patient/add_patient_screen.dart';
import 'package:frontend/ui/confirmation/confirmation_screen.dart';
import 'package:frontend/ui/home/home_screen.dart';
import 'package:frontend/ui/initiate_reset_password/initiate_reset_password_screen.dart';
import 'package:frontend/ui/login/login_screen.dart';

final Map<String, WidgetBuilder> routes = {
  '/addPatient': (context) => const AddPatientScreen(),
  // '/confirmResetPassword':(context) => const ConfirmResetPasswordScreen()
  '/confirmAccount': (context) => const ConfirmationScreen(),
  '/home':(context) => const HomeScreen(title: 'LifeSavers'),
  '/initiateResetPassword':(context) => const InitiateResetPasswordScreen(),
  '/login':(context) => const LoginScreen(),
  // '/patientData':(context) => const PatientDataScreen(),
  // '/patientsPortal': (context) => PatientPortalScreen(),
};
