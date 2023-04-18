import 'dart:convert';

import 'package:frontend/domain/patient.dart';
import 'package:http/http.dart' as http;

abstract class PatientRepository {
  Future<Patient> fetchPatient(String id);
}

class PatientDefaultRepository extends PatientRepository {
  final String baseUrl =
      '***REMOVED***';

  @override
  Future<Patient> fetchPatient(String id) async {
    final response =
        await http.get(Uri.parse('$baseUrl/GetPatientData?UserId=$id'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final Patient patient = Patient.fromJson(jsonResponse['data']);
      return patient;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load data');
    }
  }
}
