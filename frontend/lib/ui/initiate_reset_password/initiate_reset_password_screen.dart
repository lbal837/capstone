import 'package:flutter/material.dart';
import 'package:frontend/auth/user_service.dart';
import 'package:frontend/secrets.dart';
import 'package:frontend/ui/confirm_reset_password/confirm_reset_password_screen.dart';
import 'package:frontend/ui/initiate_reset_password/widgets/initiate_reset_password_button.dart';
import 'package:frontend/ui/initiate_reset_password/widgets/initiate_reset_password_email.dart';

class InitiateResetPasswordScreen extends StatefulWidget {
  const InitiateResetPasswordScreen({Key? key}) : super(key: key);

  @override
  ForgotPasswordScreenState createState() => ForgotPasswordScreenState();
}

class ForgotPasswordScreenState extends State<InitiateResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final userService = UserService(userPool);

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      userService.resetPassword(_emailController.text).then((_) {
        // After successful password reset initiation, navigate to ResetPasswordConfirmScreen
        Navigator.pushNamed(context, '/confirmResetPassword', arguments: {
          'email': _emailController.text,
          'userService': userService,
        });
      }).catchError((error) {
        // Handle any errors
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              InitiateResetPasswordEmail(emailController: _emailController),
              InitiateResetPasswordButton(onPressed: _submit),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
