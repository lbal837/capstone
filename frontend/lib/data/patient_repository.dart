import 'dart:convert';

import 'package:frontend/domain/patient.dart';
import 'package:frontend/secrets.dart';
import 'package:http/http.dart' as http;

abstract class PatientRepository {
  Future<Patient> fetchPatient(String id);

  Future<List<Patient>> fetchAllPatients();
}

class PatientDefaultRepository extends PatientRepository {
  @override
  Future<Patient> fetchPatient(String id) async {
    final response = await http
        .get(Uri.parse('$apiEndpoint/GetPatientData?UserId=$id'), headers: {
      'x-api-key': apiKey,
    });

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      final Patient patient = Patient.fromJson(jsonResponse['data']);
      return patient;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Future<List<Patient>> fetchAllPatients() async {
    final response =
        await http.get(Uri.parse('$apiEndpoint/GetAllPatientData'), headers: {
      'x-api-key': apiKey,
    });

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      final List<Patient> patients = [];
      for (final patient in jsonResponse['data']) {
        patients.add(Patient.fromJson(patient));
      }
      return patients;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
