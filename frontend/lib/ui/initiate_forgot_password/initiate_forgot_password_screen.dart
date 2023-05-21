import 'package:flutter/material.dart';
import 'package:frontend/auth/user_service.dart';
import 'package:frontend/secrets.dart';
import 'package:frontend/ui/confirm_forgot_password/confirm_forgot_password_screen.dart';
import 'package:frontend/ui/initiate_forgot_password/widgets/forgot_password_email.dart';
import 'package:frontend/ui/initiate_forgot_password/widgets/forgot_password_reset_password_button.dart';

class InitiateForgotPasswordScreen extends StatefulWidget {
  const InitiateForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  ForgotPasswordScreenState createState() => ForgotPasswordScreenState();
}

class ForgotPasswordScreenState extends State<InitiateForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final userService = UserService(userPool);

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      userService.resetPassword(_emailController.text).then((_) {
        // After successful password reset initiation, navigate to ResetPasswordConfirmScreen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResetPasswordConfirmScreen(
              email: _emailController.text,
              userService: userService,
            ),
          ),
        );
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
              ForgotPasswordEmail(emailController: _emailController),
              ResetPasswordButton(onPressed: _submit),
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
