import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final user = authViewModel.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authViewModel.signOut();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Center(
        child: user != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Exibe a imagem de perfil do usuário
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: user.photoURL != null
                        ? NetworkImage(user.photoURL!)
                        : null,
                    child: user.photoURL == null
                        ? const Icon(Icons.person, size: 50)
                        : null,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Name: ${user.displayName}",
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    "Email: ${user.email}",
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              )
            : const Text("No user logged in"),
      ),
    );
  }
}
