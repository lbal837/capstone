import 'package:flutter/material.dart';
import 'package:frontend/ui/patient_data/patient_data_screen.dart';

class ProfileBox extends StatelessWidget {
  const ProfileBox({
    Key? key,
    required this.name,
    required this.id,
    required this.picture,
  }) : super(key: key);
  final String? name;
  final String? id;
  final String? picture;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      //inkwell should make card clickable
      onTap: () {
        if (id != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PatientPage(title: 'LifeSavers', userid: id!)),
          );
        }
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
              child: CircleAvatar(
                  radius: 45, // Image radius
                  backgroundImage: NetworkImage(
                    picture!,
                  )),
            ), //size: 70)),
            Container(
              padding: const EdgeInsets.all(5.0),
              alignment: Alignment.center,
              child: Text(name!),
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
