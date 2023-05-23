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
      onPressed: onPressed,
      elevation: 5,
      hoverElevation: 25,
      heroTag: 'null',
      child: const Icon(Icons.add),
    );
  }
}
