import 'package:flutter/material.dart';
import 'package:frontend/domain/response.dart';

class AddPatientButton extends StatelessWidget {
  final Future<Response> Function() subscribeToPatient;
  final Future<Response> Function() addPatientToUser;

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
            final Response subscribeResponse = await subscribeToPatient();
            final Response addUserResponse = await addPatientToUser();

            if (subscribeResponse.isSuccess && addUserResponse.isSuccess) {
              scaffoldMessenger.showSnackBar(const SnackBar(
                  duration: Duration(milliseconds: 1000),
                  content: Text('Patient successfully added and subscribed!'),));
            } else {
              String errorMsg = 'Failed to add or subscribe patient!\n';
              if (!subscribeResponse.isSuccess) {
                errorMsg += '${subscribeResponse.message}\n';
              }
              if (!addUserResponse.isSuccess) {
                errorMsg += '${addUserResponse.message}\n';
              }

              scaffoldMessenger.showSnackBar(SnackBar(
                duration: const Duration(milliseconds: 5000),
                content: Text(errorMsg),
              ));
            }
          } catch (e) {
            scaffoldMessenger.showSnackBar(SnackBar(
              duration: const Duration(milliseconds: 5000),
              content: Text('Failed to add or subscribe patient! Error: $e'),
            ));
          }
        },
        child: const Text('Add Patient'),
      ),
    );
  }
}
