import 'package:flutter/material.dart';

class Sleep extends StatelessWidget {
  const Sleep({Key? key, required this.sleepStatus}) : super(key: key);
  final String? sleepStatus;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 109, 0, 243),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Icon(Icons.bed, size: 70)),
          Container(
            padding: const EdgeInsets.all(5.0),
            alignment: Alignment.center,
            child: const Text('SleepStatus:'),
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            alignment: Alignment.center,
            child: Text(sleepStatus!),
          ),
        ],
      ),
    );
  }
}
