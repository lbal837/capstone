import 'package:flutter/material.dart';
import 'package:frontend/ui/patients_portal/helpers/generate_aws_signature.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

Future<String?> createPlatformEndpoint({
  required String region,
  required String platformApplicationArn,
  required String? deviceToken,
  required Map<String, String?> credentials,
}) async {
  if (deviceToken == null) {
    return null;
  }

  final host = 'sns.$region.amazonaws.com';
  final endpoint = 'https://$host/';
  const method = 'POST';
  const service = 'sns';
  const path = '/';

  final payload = {
    'Action': 'CreatePlatformEndpoint',
    'PlatformApplicationArn': platformApplicationArn,
    'Token': deviceToken,
  };

  final signedRequest = generateAwsSignature(
    method: method,
    service: service,
    region: region,
    host: host,
    path: path,
    payload: payload,
    accessKey: credentials['accessKey']!,
    secretKey: credentials['secretKey']!,
    sessionToken: credentials['sessionToken'],
  );

  final headers = {
    'Content-Type': 'application/x-www-form-urlencoded',
    'X-Amz-Date': signedRequest.timestamp,
    'Authorization': signedRequest.authorizationHeader,
  };

  if (signedRequest.sessionToken != null) {
    headers['X-Amz-Security-Token'] = signedRequest.sessionToken!;
  }

  final response = await http.post(
    Uri.parse(endpoint),
    headers: headers,
    body: signedRequest.body,
  );

  if (response.statusCode == 200) {
    final xmlData = xml.XmlDocument.parse(response.body);
    final endpointArn = xmlData.findAllElements('EndpointArn').first.text;
    return endpointArn;
  } else {
    debugPrint('Error creating platform endpoint: ${response.body}');
    return null;
  }
}
