import 'package:flutter/material.dart';

class Sleep extends StatelessWidget {
  const Sleep({Key? key, required this.sleepStatus}) : super(key: key);
  final String? sleepStatus;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          const Spacer(),
          Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  gradient: const RadialGradient(
                      radius: 4, colors: [Colors.transparent, Colors.white])),
              child: const Icon(
                Icons.nights_stay,
                size: 60,
                color: Colors.deepPurple,
              )),
          Container(
            padding: const EdgeInsets.all(5.0),
            alignment: Alignment.center,
            child: const Text(
              'SleepStatus:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            alignment: Alignment.center,
            child: Text(sleepStatus!),
          ),
          const Spacer(flex: 25),
        ],
      ),
    );
  }
}
