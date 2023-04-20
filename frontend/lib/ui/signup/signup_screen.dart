import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter/material.dart';
import 'package:frontend/auth/user_service.dart';
import 'package:frontend/domain/user.dart';
import 'package:frontend/secrets.dart';
import 'package:frontend/ui/confirmation/confirmation_screen.dart';
import 'package:frontend/ui/signup/widgets/input_user_full_name.dart';
import 'package:frontend/ui/signup/widgets/signup_user_password.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  User _user = User();
  final userService = UserService(userPool);

  Future<void> submit(BuildContext context) async {
    _formKey.currentState?.save();

    String message;
    var signUpSuccess = false;
    if (_user.email != null && _user.password != null && _user.name != null) {
      try {
        _user = await userService.signUp(
            _user.email!, _user.password!, _user.name!);
        signUpSuccess = true;
        message = 'User sign up successful!';
      } on CognitoClientException catch (e) {
        if (e.code == 'UsernameExistsException' ||
            e.code == 'InvalidParameterException' ||
            e.code == 'InvalidPasswordException' ||
            e.code == 'ResourceNotFoundException') {
          message = e.message ?? e.code ?? e.toString();
        } else {
          message = 'Unknown client error occurred';
        }
      } catch (e) {
        message = 'Unknown error occurred';
      }
    } else {
      message = 'Missing required attributes on user';
    }

    final snackBar = SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: 'OK',
        onPressed: () {
          if (signUpSuccess) {
            Navigator.pop(context);
            if (!_user.confirmed) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ConfirmationScreen(email: _user.email!)),
              );
            }
          }
        },
      ),
      duration: const Duration(seconds: 30),
    );
    void showSnackBar() {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    showSnackBar();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Builder(
        builder: (BuildContext context) {
          return Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                InputUserFullName(user: _user),
                ListTile(
                  leading: const Icon(Icons.email),
                  title: TextFormField(
                    decoration: const InputDecoration(
                        hintText: 'example@inspire.my', labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (n) => _user.email = n,
                  ),
                ),
                SignupUserPassword(user: _user),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  width: screenSize.width,
                  margin: const EdgeInsets.only(
                    top: 10.0,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      submit(context);
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
