import 'package:flutter/material.dart';
import 'package:frontend/auth/user_service.dart';
import 'package:frontend/ui/confirm_reset_password/widgets/confirm_reset_password_button.dart';
import 'package:frontend/ui/confirm_reset_password/widgets/confirm_reset_password_confirmation_code.dart';
import 'package:frontend/ui/confirm_reset_password/widgets/confirm_reset_password_new_password.dart';

class ConfirmResetPasswordScreen extends StatefulWidget {
  final String email;
  final UserService userService;

  const ConfirmResetPasswordScreen({
    Key? key,
    required this.email,
    required this.userService,
  }) : super(key: key);

  @override
  ResetPasswordConfirmScreenState createState() =>
      ResetPasswordConfirmScreenState();
}

class ResetPasswordConfirmScreenState
    extends State<ConfirmResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      widget.userService
          .confirmNewPassword(
        widget.email,
        _codeController.text,
        _passwordController.text,
      )
          .then((_) {
        Navigator.pushNamed(
          context,
          '/login',
        );
      }).catchError((error) {
        debugPrint(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm New Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              ConfirmResetPasswordCode(controller: _codeController),
              ConfirmResetPasswordNewPassword(controller: _passwordController),
              ConfirmResetPasswordButton(onPressed: _submit),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _codeController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
