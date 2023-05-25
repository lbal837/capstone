import 'package:flutter/material.dart';

class GPSWidget extends StatelessWidget {
  const GPSWidget({
    Key? key,
    required this.latitude,
    required this.longitude,
  }) : super(key: key);
  final String? latitude;
  final String? longitude;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          const Spacer(),
          Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  gradient: const RadialGradient(
                      radius: 4, colors: [Colors.transparent, Colors.white])),
              child: const Icon(
                Icons.location_on,
                size: 60,
                color: Colors.cyan,
              )),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(5.0),
            alignment: Alignment.center,
            child: const Text(
              'Location:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
                left: 10.0, top: 10.0, right: 0.1, bottom: 10.0),
            alignment: Alignment.center,
            child: Text(latitude!),
          ),
          Container(
            padding: const EdgeInsets.only(
                left: 0.1, top: 10.0, right: 1.0, bottom: 10.0),
            alignment: Alignment.center,
            child: const Text(','),
          ),
          Container(
            padding: const EdgeInsets.only(
                left: 5.0, top: 10.0, right: 10.0, bottom: 10.0),
            alignment: Alignment.center,
            child: Text(longitude!),
          ),
          const Spacer(flex: 3),
        ],
      ),
    );
  }
}
