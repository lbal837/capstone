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
                    PatientDataScreen(title: 'LifeSavers', userid: id!)),
          );
        }
      },
      child: Card(
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: CircleAvatar(
                  radius: 35, // Image radius
                  backgroundImage: NetworkImage(
                    picture!,
                  )),
            ), //size: 70)),
            Container(
              padding: const EdgeInsets.all(5.0),
              alignment: Alignment.center,
              child: Text(
                name!,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const Spacer(
              flex: 2, // <-- SEE HERE
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              alignment: Alignment.centerRight,
              child: const Text('Status'),
            ),
          ],
        ),
      ),
    );
  }
}
