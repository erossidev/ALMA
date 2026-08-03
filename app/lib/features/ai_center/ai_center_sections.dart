import 'package:flutter/material.dart';

import 'models/ai_center_section.dart';
import 'pages/ai_dashboard_page.dart';
import 'pages/ai_routing_page.dart';

final List<AICenterSection> aiCenterSections = [
  const AICenterSection(
    id: 'dashboard',
    title: 'Dashboard',
    icon: Icons.dashboard_outlined,
    page: AIDashboardPage(),
  ),

  const AICenterSection(
    id: 'routing',
    title: 'Routing',
    icon: Icons.route_outlined,
    page: AIRoutingPage(),
  ),
];