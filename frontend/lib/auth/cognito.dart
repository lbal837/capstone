import 'package:amazon_cognito_identity_dart_2/cognito.dart';

class Cognito {
  final String _userPoolId = 'your_user_pool_id';
  final String _appClientId = 'your_app_client_id';
  final CognitoUserPool _userPool;

  Cognito()
      : _userPool = CognitoUserPool('your_user_pool_id', 'your_app_client_id');

  Future<void> signUp(String email, String password) async {
    try {
      final userAttributes = [AttributeArg(name: 'email', value: email)];
      final result = await _userPool.signUp(email, password,
          userAttributes: userAttributes);
      print('Sign up successful: ${result.userConfirmed}');
    } catch (e) {
      print('Failed to sign up: $e');
    }
  }

  Future<void> signIn(String email, String password) async {
    final cognitoUser =
        CognitoUser(email, _userPool, storage: _userPool.storage);
    final authDetails =
        AuthenticationDetails(username: email, password: password);

    try {
      final session = await cognitoUser.authenticateUser(authDetails);
      print('Sign in successful: ${session?.isValid()}');
    } catch (e) {
      print('Failed to sign in: $e');
    }
  }
}
