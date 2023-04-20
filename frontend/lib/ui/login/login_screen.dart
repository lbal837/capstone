import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter/material.dart';
import 'package:frontend/auth/user_service.dart';
import 'package:frontend/domain/user.dart';
import 'package:frontend/secrets.dart';
import 'package:frontend/ui/confirmation/confirmation_screen.dart';
import 'package:frontend/ui/home/home.dart';
import 'package:frontend/ui/home/widgets/home_login_user_button.dart';
import 'package:frontend/ui/login/widgets/input_user_login.dart';
import 'package:frontend/ui/login/widgets/input_user_password.dart';
import 'package:frontend/ui/login/widgets/login_user_button.dart';

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
  bool _isAuthenticated = false;

  Future<UserService> _getValues() async {
    await _userService.init();
    _isAuthenticated = await _userService.checkAuthenticated();
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
          message = 'User sucessfully logged in!';
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
          message = 'An unknown client error occured';
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
              await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ConfirmationScreen(
                        email: _user.email ?? 'no email found')),
              );
            } else {
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const MyHomePage(title: 'Login Successful')));
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
    return FutureBuilder(
        future: _getValues(),
        builder: (context, AsyncSnapshot<UserService> snapshot) {
          if (snapshot.hasData) {
            if (_isAuthenticated) {
              return const MyHomePage(title: 'You are authenticated');
            }
            final screenSize = MediaQuery.of(context).size;
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
                        InputUserLogin(widget: widget, user: _user),
                        InputUserPassword(user: _user),
                        UserLoginButton(onPressed: () => submit(context)),
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
