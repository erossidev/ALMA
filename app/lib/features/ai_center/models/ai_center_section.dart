import 'package:flutter/material.dart';

import '../../../shared/navigation/navigation_item.dart';

class AICenterSection implements NavigationItem {
  @override
  final String id;

  @override
  final String title;

  @override
  final IconData icon;

  @override
  final Widget page;

  const AICenterSection({
    required this.id,
    required this.title,
    required this.icon,
    required this.page,
  });
}