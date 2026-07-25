import 'package:flutter/material.dart';

import '../../core/alma/alma.dart';
import '../home/home_page.dart';

class AlmaLoader extends StatefulWidget {
  const AlmaLoader({super.key});

  @override
  State<AlmaLoader> createState() => _AlmaLoaderState();
}

class _AlmaLoaderState extends State<AlmaLoader> {
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await Alma.instance.initialize();

    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}