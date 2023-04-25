import 'package:flutter/material.dart'; //this is a card

class HeartRateWidget extends StatelessWidget {
  const HeartRateWidget({Key? key, required String? this.heartrate})
      : super(key: key);
  final heartrate;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 243, 0, 105),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Icon(Icons.monitor_heart, size: 70)),
          Container(
            padding: const EdgeInsets.all(5.0),
            alignment: Alignment.center,
            child: const Text('HeartRate:'),
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            alignment: Alignment.center,
            child: Text(heartrate),
          ),
        ],
      ),
    );
  }
}
