import 'package:flutter/material.dart';

class AlmaScaffold extends StatelessWidget {
  final Widget child;
  final String? title;

  const AlmaScaffold({
    super.key,
    required this.child,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B132B),
      appBar: title != null
          ? AppBar(
              title: Text(title!),
              backgroundColor: const Color(0xFF0B132B),
              foregroundColor: Colors.white,
              elevation: 0,
            )
          : null,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: child,
        ),
      ),
    );
  }
}