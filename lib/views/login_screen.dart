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
        child: Column(
          mainAxisSize: MainAxisSize.min, // Para centralizar o conteúdo verticalmente
          children: [
            // Adicione a logo do Google
            Image.asset(
              'assets/google.png', // Substitua pelo caminho correto da logo no seu projeto
              height: 100, // Altura da logo
            ),
            const SizedBox(height: 20), // Espaço entre a logo e o botão
            ElevatedButton(
              onPressed: () async {
                await authViewModel.signInWithGoogle();
                if (authViewModel.currentUser != null) {
                  Navigator.pushReplacementNamed(context, '/home');
                }
              },
              child: const Text("Login with Google"),
            ),
          ],
        ),
      ),
    );
  }
}
