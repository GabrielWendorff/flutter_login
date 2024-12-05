import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_view_model.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await authViewModel.signInWithGoogle();
            if (authViewModel.currentUser != null) {
              Navigator.pushReplacementNamed(context, '/home');
            }
          },
          child: const Text("Login with Google"),
        ),
      ),
    );
  }
}
