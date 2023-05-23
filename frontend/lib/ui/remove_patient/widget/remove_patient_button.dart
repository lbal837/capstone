import 'package:flutter/material.dart';

class RemovePatientButton extends StatelessWidget {
  final Future<bool> Function() unsubscribeFromPatient;
  final Future<bool> Function() removePatientFromUser;

  const RemovePatientButton({
    Key? key,
    required this.unsubscribeFromPatient,
    required this.removePatientFromUser,
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
            final bool subscribeSuccess = await unsubscribeFromPatient();
            final bool addUserSuccess = await removePatientFromUser();

            if (subscribeSuccess && addUserSuccess) {
              scaffoldMessenger.showSnackBar(const SnackBar(
                  duration: Duration(milliseconds: 500),
                  content: Text('Patient successfully removed and unsubscribed!')));
            } else {
              scaffoldMessenger.showSnackBar(const SnackBar(
                  duration: Duration(milliseconds: 500),
                  content: Text('Failed to remove or unsubscribe patient!')));
            }
          } catch (e) {
            scaffoldMessenger.showSnackBar(SnackBar(
                duration: const Duration(milliseconds: 500),
                content:
                Text('Failed to remove or unsubscribe patient! Error: $e')));
          }
        },
        child: const Text('Remove Patient'),
      ),
    );
  }
}
