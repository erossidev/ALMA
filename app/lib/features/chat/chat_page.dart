import 'package:flutter/material.dart';

import '../../shared/widgets/alma_scaffold.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AlmaScaffold(
      title: 'Chat con ALMA',
      child: Center(
        child: Text(
          '👋 Ciao!\n\nSono ALMA.\n\nCome posso aiutarti oggi?',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
      ),
    );
  }
}