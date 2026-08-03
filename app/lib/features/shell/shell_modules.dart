import 'package:flutter/material.dart';

import '../chat/chat_page.dart';
import 'models/alma_module.dart';

final List<AlmaModule> almaModules = [
  const AlmaModule(
    id: 'chat',
    title: 'Chat',
    icon: Icons.chat_bubble_outline,
    page: ChatPage(),
  ),
];