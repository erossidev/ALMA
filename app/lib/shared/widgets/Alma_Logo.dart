import 'package:flutter/material.dart';

class AlmaLogo extends StatelessWidget {
  final double size;

  const AlmaLogo({
    super.key,
    this.size = 180,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/alma_logo.png',
      width: size,
    );
  }
}