import 'package:flutter/material.dart';
import 'package:frontend/ui/patient/patient.dart';

class ProfileBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      //inkwell should make card clickable
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const MyDataPage(title: 'LifeSavers')),
        );
      },
      child: Card(
        child: Row(
          children: [
            Container(
                padding: const EdgeInsets.all(30.0),
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(Icons.account_circle, size: 70)),
            Container(
              padding: const EdgeInsets.all(5.0),
              alignment: Alignment.center,
              child: const Text('Patient Name/ Number'),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              alignment: Alignment.center,
              child: const Text('Status'),
            ),
          ],
        ),
      ),
    );
  }
}
