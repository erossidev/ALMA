import 'package:flutter/material.dart';

import '../../../shared/navigation/module_shell.dart';

import '../ai_center_sections.dart';
import '../models/ai_center_section.dart';

class AICenterPage extends StatelessWidget {
  const AICenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ModuleShell<AICenterSection>(
      title: 'AI Center',
      items: aiCenterSections,
    );
  }
}