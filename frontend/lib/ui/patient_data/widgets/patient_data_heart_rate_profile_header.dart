import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HeartRateWidget extends StatelessWidget {
  const HeartRateWidget({Key? key, required this.heartRate}) : super(key: key);
  final String? heartRate;

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
                radius: 4,
                colors: [Colors.transparent, Colors.white],
              ),
            ),
            child: const SpinKitPumpingHeart(
              color: Colors.red,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(5.0),
            alignment: Alignment.center,
            child: const Text(
              'HeartRate:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            alignment: Alignment.center,
            child: Text(heartRate!),
          ),
          const Spacer(flex: 25),
        ],
      ),
    );
  }
}
