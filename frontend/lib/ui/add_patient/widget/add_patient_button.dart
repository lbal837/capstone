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
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Patient successfully added and subscribed!')));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Failed to add or subscribe patient!')));
            }
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content:
                    Text('Failed to add or subscribe patient! Error: $e')));
          }
        },
        child: const Text('Add Patient'),
      ),
    );
  }
}
