import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

class AwsSnsHelper {
  final String accessKeyId;
  final String secretAccessKey;
  final String region;

  AwsSnsHelper({
    required this.accessKeyId,
    required this.secretAccessKey,
    required this.region,
  });

  // Helper function to generate the AWS Signature Version 4
  String _generateAwsSigV4({
    required String method,
    required String service,
    required String host,
    required String region,
    required String requestParameters,
    required String canonicalUri,
    required String date,
    required String dateTime,
  }) {
    final canonicalRequest =
        '$method\n$canonicalUri\n$requestParameters\nhost:$host\nx-amz-date:$dateTime\n\nhost;x-amz-date\n${sha256.convert(utf8.encode(requestParameters)).toString()}';
    final stringToSign =
        'AWS4-HMAC-SHA256\n$date\n$region/$service/aws4_request\n${sha256.convert(utf8.encode(canonicalRequest)).toString()}';
    final signingKey = Hmac(sha256, utf8.encode('AWS4$secretAccessKey'))
        .convert(utf8.encode(date))
        .bytes;
    final signature =
        Hmac(sha256, signingKey).convert(utf8.encode(stringToSign)).toString();

    return signature;
  }

  // Create an SNS topic
  Future<String> createTopic(String topicName) async {
    final endpoint = 'https://sns.$region.amazonaws.com/';
    final host = 'sns.$region.amazonaws.com';
    const service = 'sns';
    const canonicalUri = '/';
    final dateTime =
        '${DateTime.now().toUtc().toString().replaceAll(' ', 'T')}Z';
    final date = dateTime.substring(0, 8);

    final requestParameters =
        'Action=CreateTopic&Name=$topicName&Version=2010-03-31';

    final signature = _generateAwsSigV4(
      method: 'POST',
      service: service,
      host: host,
      region: region,
      requestParameters: requestParameters,
      canonicalUri: canonicalUri,
      date: date,
      dateTime: dateTime,
    );

    final headers = {
      'Host': host,
      'Content-Type': 'application/x-www-form-urlencoded',
      'X-Amz-Date': dateTime,
      'Authorization':
          'AWS4-HMAC-SHA256 Credential=$accessKeyId/$date/$region/$service/aws4_request, SignedHeaders=host;x-amz-date, Signature=$signature',
    };

    final response = await http.post(
      Uri.parse(endpoint),
      headers: headers,
      body: requestParameters,
    );

    if (response.statusCode == 200) {
      final xmlResponse = xml.XmlDocument.parse(response.body);
      final topicArn = xmlResponse.findAllElements('TopicArn').first.text;
      return topicArn;
    } else {
      throw Exception('Failed to create SNS topic');
    }
  }

  // Subscribe an endpoint to a topic
  Future<void> subscribe(
      String topicArn, String protocol, String endpoint) async {
    final snsEndpoint = 'https://sns.$region.amazonaws.com/';
    final host = 'sns.$region.amazonaws.com';
    const service = 'sns';
    const canonicalUri = '/';
    final dateTime =
        '${DateTime.now().toUtc().toString().replaceAll(' ', 'T')}Z';
    final date = dateTime.substring(0, 8);

    final requestParameters =
        'Action=Subscribe&Endpoint=$endpoint&Protocol=$protocol&TopicArn=$topicArn&Version=2010-03-31';

    final signature = _generateAwsSigV4(
      method: 'POST',
      service: service,
      host: host,
      region: region,
      requestParameters: requestParameters,
      canonicalUri: canonicalUri,
      date: date,
      dateTime: dateTime,
    );

    final headers = {
      'Host': host,
      'Content-Type': 'application/x-www-form-urlencoded',
      'X-Amz-Date': dateTime,
      'Authorization':
          'AWS4-HMAC-SHA256 Credential=$accessKeyId/$date/$region/$service/aws4_request, SignedHeaders=host;x-amz-date, Signature=$signature',
    };

    final response = await http.post(
      Uri.parse(snsEndpoint),
      headers: headers,
      body: requestParameters,
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to subscribe to SNS topic');
    }
  }
}
