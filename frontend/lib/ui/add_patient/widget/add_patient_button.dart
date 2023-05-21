import 'dart:async';

import 'package:flutter/material.dart';

class AddPatientButton extends StatelessWidget {
  final Future<void> Function() subscribeToPatient;
  final Future<void> Function() addPatientToUser;

  const AddPatientButton({
    Key? key,
    required this.subscribeToPatient,
    required this.addPatientToUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(20.0),
      width: screenSize.width,
      margin: const EdgeInsets.only(
        top: 10.0,
      ),
      child: ElevatedButton(
        onPressed: () {
          final completer = Completer<void>();
          try {
            subscribeToPatient().then((_) => addPatientToUser()).then((_) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Patient successfully added and subscribed!')));
              completer.complete();
            });
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Failed to add or subscribe patient!')));
            completer.completeError(e);
          }
        },
        child: const Text('Add Patient'),
      ),
    );
  }
}
