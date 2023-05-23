import 'package:flutter/material.dart';

class PatientsPortalAddPatientButton extends StatelessWidget {
  final VoidCallback onPressed;

  const PatientsPortalAddPatientButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'addPatient',
      onPressed: onPressed,
      elevation: 5,
      hoverElevation: 25,
      child: const Icon(Icons.add),
    );
  }
}
