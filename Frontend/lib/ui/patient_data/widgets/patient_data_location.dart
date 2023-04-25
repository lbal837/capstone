import 'package:flutter/material.dart';

class GPSWidget extends StatelessWidget {
  const GPSWidget({
    Key? key,
    required String? this.latitude,
    required String? this.longitude,
  }) : super(key: key);
  final latitude;
  final longitude;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 0, 57, 243),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Icon(Icons.location_on, size: 70)),
          Container(
            padding: const EdgeInsets.all(5.0),
            alignment: Alignment.center,
            child: const Text('Location:'),
          ),
          Container(
            padding: const EdgeInsets.only(
                left: 10.0, top: 10.0, right: 0.1, bottom: 10.0),
            alignment: Alignment.center,
            child: Text(latitude),
          ),
          Container(
            padding: const EdgeInsets.only(
                left: 0.1, top: 10.0, right: 1.0, bottom: 10.0),
            alignment: Alignment.center,
            child: Text(','),
          ),
          Container(
            padding: const EdgeInsets.only(
                left: 5.0, top: 10.0, right: 10.0, bottom: 10.0),
            alignment: Alignment.center,
            child: Text(longitude),
          ),
        ],
      ),
    );
  }
}
