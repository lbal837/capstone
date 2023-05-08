import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:intl/intl.dart';

AwsSignedRequest generateAwsSignature({
  required String method,
  required String service,
  required String region,
  required String host,
  required String path,
  required Map<String, String> payload,
  required String accessKey,
  required String secretKey,
  String? sessionToken,
}) {
  final now = DateTime.now().toUtc();
  final timestamp = '${DateFormat('yyyyMMddTHHmmss').format(now)}Z';
  final dateStamp = DateFormat('yyyyMMdd').format(now);
  final canonicalUri = path;
  const canonicalQueryString = '';
  final payloadString = payload.keys
      .map((key) =>
          '${Uri.encodeComponent(key)}=${Uri.encodeComponent(payload[key]!)}')
      .join('&');

  var canonicalHeaders =
      'content-type:application/x-www-form-urlencoded\nhost:$host\nx-amz-date:$timestamp\n';
  if (sessionToken != null) {
    canonicalHeaders += 'x-amz-security-token:$sessionToken\n';
  }
  final signedHeaders =
      'content-type;host;x-amz-date${sessionToken != null ? ';x-amz-security-token' : ''}';

  final canonicalRequest =
      '$method\n$canonicalUri\n$canonicalQueryString\n$canonicalHeaders\n$signedHeaders\n${sha256.convert(utf8.encode(payloadString))}';

  final credentialScope = '$dateStamp/$region/$service/aws4_request';
  final stringToSign =
      'AWS4-HMAC-SHA256\n$timestamp\n$credentialScope\n${sha256.convert(utf8.encode(canonicalRequest))}';

  final signingKey = getSignatureKey(secretKey, dateStamp, region, service);
  final signature =
      Hmac(sha256, signingKey).convert(utf8.encode(stringToSign)).toString();

  final authorizationHeader =
      'AWS4-HMAC-SHA256 Credential=$accessKey/$credentialScope, SignedHeaders=$signedHeaders, Signature=$signature';

  return AwsSignedRequest(
    timestamp: timestamp,
    authorizationHeader: authorizationHeader,
    sessionToken: sessionToken,
    body: payloadString,
  );
}

List<int> getSignatureKey(
    String key, String dateStamp, String regionName, String serviceName) {
  final kDate =
      Hmac(sha256, utf8.encode('AWS4$key')).convert(utf8.encode(dateStamp));
  final kRegion = Hmac(sha256, kDate.bytes).convert(utf8.encode(regionName));
  final kService =
      Hmac(sha256, kRegion.bytes).convert(utf8.encode(serviceName));
  final kSigning =
      Hmac(sha256, kService.bytes).convert(utf8.encode('aws4_request'));
  return kSigning.bytes;
}

class AwsSignedRequest {
  final String timestamp;
  final String authorizationHeader;
  final String? sessionToken;
  final String body;

  AwsSignedRequest({
    required this.timestamp,
    required this.authorizationHeader,
    this.sessionToken,
    required this.body,
  });
}
