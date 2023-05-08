import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:frontend/secrets.dart';
import 'package:frontend/ui/patients_portal/helpers/create_platform_endpoint.dart';
import 'package:frontend/ui/patients_portal/helpers/get_temporary_aws_credentials.dart';

class SnsEndpointCreator extends StatefulWidget {
  const SnsEndpointCreator({super.key});

  @override
  SnsEndpointCreatorState createState() => SnsEndpointCreatorState();
}

class SnsEndpointCreatorState extends State<SnsEndpointCreator> {
  bool _isProcessing = false;
  String? _resultMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: _isProcessing
                ? null
                : () async {
                    setState(() {
                      _isProcessing = true;
                      _resultMessage = null;
                    });

                    final firebaseMessaging = FirebaseMessaging.instance;

                    final temporaryCredentials =
                        await getTemporaryAwsCredentials(
                            cognitoIdentityPoolId, region);
                    if (temporaryCredentials != null) {
                      final response = await createPlatformEndpoint(
                        region: region,
                        platformApplicationArn: snsArn,
                        deviceToken: await firebaseMessaging.getToken(),
                        credentials: temporaryCredentials,
                      );

                      setState(() {
                        _resultMessage = response != null
                            ? 'Platform endpoint created: $response'
                            : 'Error creating platform endpoint';
                      });
                    } else {
                      setState(() {
                        _resultMessage =
                            'Error retrieving temporary AWS credentials';
                      });
                    }

                    setState(() {
                      _isProcessing = false;
                    });
                  },
            child: const Text('Create SNS Endpoint'),
          ),
          if (_resultMessage != null)
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(_resultMessage!),
            ),
        ],
      ),
    );
  }
}
