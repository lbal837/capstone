import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter/material.dart';
import 'package:frontend/auth/user_service.dart';
import 'package:frontend/domain/user.dart';
import 'package:frontend/secrets.dart';
import 'package:frontend/ui/confirmation/confirmation_screen.dart';
import 'package:frontend/ui/home/home_screen.dart';
import 'package:frontend/ui/login/widgets/login_go_back_button.dart';
import 'package:frontend/ui/login/widgets/login_reset_password_button.dart';
import 'package:frontend/ui/login/widgets/login_user_button.dart';
import 'package:frontend/ui/login/widgets/login_user_email.dart';
import 'package:frontend/ui/login/widgets/login_user_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, this.email}) : super(key: key);

  final String? email;

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _userService = UserService(userPool);
  User _user = User();

  Future<UserService> _getValues() async {
    await _userService.init();
    return _userService;
  }

  Future<void> submit(BuildContext context) async {
    _formKey.currentState?.save();
    String message;
    if (_user.email != null && _user.password != null) {
      try {
        final u = await _userService.login(_user.email!, _user.password!);
        if (u == null) {
          message = 'Could not login user';
        } else {
          _user = u;
          message = 'User successfully logged in!';
          if (!_user.confirmed) {
            message = 'Please confirm user account';
          }
        }
      } on CognitoClientException catch (e) {
        if (e.code == 'InvalidParameterException' ||
            e.code == 'NotAuthorizedException' ||
            e.code == 'UserNotFoundException' ||
            e.code == 'ResourceNotFoundException') {
          message = e.message ?? e.code ?? e.toString();
        } else {
          message = 'An unknown client error occurred';
        }
      } catch (e) {
        message = 'An unknown error occurred';
      }
    } else {
      message = 'Missing required attributes on user';
    }
    final snackBar = SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: 'OK',
        onPressed: () async {
          if (_user.hasAccess) {
            Navigator.pop(context);
            if (!_user.confirmed) {
              await Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ConfirmationScreen(
                          email: _user.email ?? 'no email found')),
                  (Route<dynamic> route) => false);
            } else {
              await Navigator.pushNamedAndRemoveUntil(
                  context, '/home', (Route<dynamic> route) => false);
            }
          }
        },
      ),
      duration: const Duration(seconds: 30),
    );

    void showSnackBar() {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    showSnackBar();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return FutureBuilder(
        future: _getValues(),
        builder: (context, AsyncSnapshot<UserService> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Login'),
              ),
              body: Builder(
                builder: (BuildContext context) {
                  return Form(
                    key: _formKey,
                    child: ListView(
                      children: <Widget>[
                        LoginUserEmail(widget: widget, user: _user),
                        LoginUserPassword(user: _user),
                        LoginUserButton(onPressed: () => submit(context)),
                        LoginResetPasswordButton(screenSize: screenSize),
                        LoginGoBackButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                  );
                },
              ),
            );
          }
          return Scaffold(appBar: AppBar(title: const Text('Loading...')));
        });
  }
}
