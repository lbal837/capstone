import 'package:flutter/material.dart';
import 'package:frontend/auth/user_service.dart';
import 'package:frontend/ui/login/login_screen.dart';

class ResetPasswordConfirmScreen extends StatefulWidget {
  final String email;
  final UserService userService;

  const ResetPasswordConfirmScreen(
      {Key? key, required this.email, required this.userService})
      : super(key: key);

  @override
  ResetPasswordConfirmScreenState createState() =>
      ResetPasswordConfirmScreenState();
}

class ResetPasswordConfirmScreenState
    extends State<ResetPasswordConfirmScreen> {
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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
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
        title: const Text('Confirm New Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _codeController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the confirmation code';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Confirmation Code',
                ),
              ),
              TextFormField(
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your new password';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'New Password',
                ),
                obscureText: true,
              ),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Submit'),
              ),
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
