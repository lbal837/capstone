import 'package:flutter/material.dart';
import 'package:frontend/domain/response.dart';

class RemovePatientButton extends StatelessWidget {
  final Future<Response> Function() unsubscribeFromPatient;
  final Future<Response> Function() removePatientFromUser;
  final VoidCallback afterSuccessfulRemoval;

  const RemovePatientButton({
    Key? key,
    required this.unsubscribeFromPatient,
    required this.removePatientFromUser,
    required this.afterSuccessfulRemoval,
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
            final Response unsubscribeResponse = await unsubscribeFromPatient();
            final Response removeUserResponse = await removePatientFromUser();

            if (unsubscribeResponse.isSuccess && removeUserResponse.isSuccess) {
              scaffoldMessenger.showSnackBar(const SnackBar(
                  duration: Duration(milliseconds: 1000),
                  content:
                      Text('Patient successfully removed and unsubscribed!')));
              afterSuccessfulRemoval();
            } else {
              String errorMsg = 'Failed to remove or unsubscribe patient!\n';
              if (!unsubscribeResponse.isSuccess) {
                errorMsg += '${unsubscribeResponse.message}\n';
              }
              if (!removeUserResponse.isSuccess) {
                errorMsg += '${removeUserResponse.message}\n';
              }

              scaffoldMessenger.showSnackBar(SnackBar(
                  duration: const Duration(milliseconds: 5000),
                  content: Text(errorMsg)));
            }
          } catch (e) {
            scaffoldMessenger.showSnackBar(SnackBar(
                duration: const Duration(milliseconds: 5000),
                content: Text(
                    'Failed to remove or unsubscribe patient! Error: $e')));
          }
        },
        child: const Text('Remove Patient'),
      ),
    );
  }
}
