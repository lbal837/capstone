import 'package:flutter/material.dart';

class PatientsPortalRemovePatientButton extends StatelessWidget {
  final VoidCallback onPressed;

  const PatientsPortalRemovePatientButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'removePatient',
      onPressed: onPressed,
      elevation: 5,
      hoverElevation: 25,
      child: const Icon(Icons.remove),
    );
  }
}
