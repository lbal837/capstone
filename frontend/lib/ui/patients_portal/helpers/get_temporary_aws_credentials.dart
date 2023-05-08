import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Map<String, String>?> getTemporaryAwsCredentials(
    String identityPoolId, String region) async {
  final url =
      'https://cognito-identity.$region.amazonaws.com/getCredentialsForIdentity';
  final host = 'cognito-identity.$region.amazonaws.com';

  final payload = jsonEncode({
    'IdentityId': identityPoolId,
  });

  final headers = {
    'Content-Type': 'application/x-amz-json-1.1',
    'X-Amz-Target': 'AWSCognitoIdentityService.GetCredentialsForIdentity',
    'Host': host,
  };

  final response = await http.post(
    Uri.parse(url),
    headers: headers,
    body: payload,
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return {
      'accessKey': data['Credentials']['AccessKeyId'],
      'secretKey': data['Credentials']['SecretKey'],
      'sessionToken': data['Credentials']['SessionToken'],
    };
  } else {
    debugPrint('Error retrieving temporary AWS credentials: ${response.body}');
    return null;
  }
}
