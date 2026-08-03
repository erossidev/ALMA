import 'package:flutter/material.dart';
import '../ai_center/pages/ai_center_page.dart';

import '../chat/chat_page.dart';
import 'models/alma_module.dart';

final List<AlmaModule> almaModules = [
  const AlmaModule(
    id: 'chat',
    title: 'Chat',
    icon: Icons.chat_bubble_outline,
    page: ChatPage(),
  ),

  const AlmaModule(
    id: 'ai_center',
    title: 'AI Center',
    icon: Icons.smart_toy_outlined,
    page: AICenterPage(),
  ),
];