import 'package:flutter/material.dart';
import '../../shared/widgets/alma_logo.dart';
import '../../shared/widgets/alma_button.dart';
import '../../shared/widgets/alma_scaffold.dart';
import '../chat/chat_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
   return AlmaScaffold(
  child: Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const AlmaLogo(size: 190),
        const SizedBox(height: 40),

        Text(
          'ALMA',
          style: Theme.of(context).textTheme.headlineLarge,
        ),

        const SizedBox(height: 10),

        Text(
          'Adaptive Learning Memory Assistant',
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 50),

		AlmaButton(
		  text: 'Inizia',
		  onPressed: () {
			Navigator.push(
			  context,
			  MaterialPageRoute(
				builder: (_) => const ChatPage(),
			  ),
			);
		  },
),
      ],
    ),
  ),
);
  }
}