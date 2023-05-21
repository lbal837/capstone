import 'package:flutter/material.dart';

class AddPatientId extends StatelessWidget {
  final TextEditingController controller;

  const AddPatientId({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: Colors.grey,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
        hintText: 'Enter Patient ID',
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 18),
      ),
    );
  }
}
