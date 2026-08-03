import 'package:flutter/material.dart';

import '../../shared/navigation/module_shell.dart';

import 'shell_modules.dart';

class AlmaShellPage extends StatelessWidget {
  const AlmaShellPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ModuleShell(
      title: 'ALMA',
      items: almaModules,
    );
  }
}