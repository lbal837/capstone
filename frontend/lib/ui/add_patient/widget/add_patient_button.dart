import 'package:flutter/material.dart';

class AddPatientButton extends StatelessWidget {
  final Future<bool> Function() subscribeToPatient;
  final Future<bool> Function() addPatientToUser;

  const AddPatientButton({
    Key? key,
    required this.subscribeToPatient,
    required this.addPatientToUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    return Container(
      padding: const EdgeInsets.all(20.0),
      width: screenSize.width,
      margin: const EdgeInsets.only(
        top: 10.0,
      ),
      child: ElevatedButton(
        onPressed: () async {
          try {
            final bool subscribeSuccess = await subscribeToPatient();
            final bool addUserSuccess = await addPatientToUser();

            if (subscribeSuccess && addUserSuccess) {
              scaffoldMessenger.showSnackBar(const SnackBar(
                  duration: Duration(milliseconds: 1000),
                  content: Text('Patient successfully added and subscribed!')));
            } else {
              scaffoldMessenger.showSnackBar(const SnackBar(
                  duration: Duration(milliseconds: 1000),
                  content: Text('Failed to add or subscribe patient!')));
            }
          } catch (e) {
            scaffoldMessenger.showSnackBar(SnackBar(
                duration: const Duration(milliseconds: 1000),
                content:
                    Text('Failed to add or subscribe patient! Error: $e')));
          }
        },
        child: const Text('Add Patient'),
      ),
    );
  }
}
