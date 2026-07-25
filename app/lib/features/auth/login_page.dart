import 'package:flutter/material.dart';
import '../../services/auth_service.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = AuthService();

    return Scaffold(
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () async {
            final user = await auth.signInWithGoogle();

            if (user == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Accesso annullato"),
                ),
              );
            }
          },
          icon: const Icon(Icons.login),
          label: const Text("Accedi con Google"),
        ),
      ),
    );
  }
}