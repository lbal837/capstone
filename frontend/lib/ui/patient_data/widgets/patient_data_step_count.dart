import 'package:flutter/material.dart';

class StepCountWidget extends StatelessWidget {
  const StepCountWidget({Key? key, required this.stepCount}) : super(key: key);
  final double? stepCount;

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
                  color: const Color.fromARGB(255, 166, 0, 243),
                  borderRadius: BorderRadius.circular(100),
                  gradient: const RadialGradient(
                      radius: 4, colors: [Colors.transparent, Colors.white])),
              child: const Icon(
                Icons.directions_walk,
                size: 60,
                color: Colors.green,
              )),
          Container(
            padding: const EdgeInsets.all(5.0),
            alignment: Alignment.center,
            child: const Text(
              'Step count within the past minute:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            alignment: Alignment.center,
            child:
                Text(stepCount.toString()), //kinda want to make it an int first
          ),
          const Spacer(flex: 25),
        ],
      ),
    );
  }
}
