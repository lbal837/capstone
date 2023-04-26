import 'package:flutter/material.dart';

class StepCountWidget extends StatelessWidget {
  const StepCountWidget({Key? key, required this.stepCount}) : super(key: key);
  final double? stepCount;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 166, 0, 243),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Icon(Icons.directions_walk, size: 70)),
          Container(
            padding: const EdgeInsets.all(5.0),
            alignment: Alignment.center,
            child: const Text('Todays step count:'),
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            alignment: Alignment.center,
            child:
                Text(stepCount.toString()), //kinda want to make it an int first
          ),
        ],
      ),
    );
  }
}
