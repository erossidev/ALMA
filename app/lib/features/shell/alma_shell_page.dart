import 'package:flutter/material.dart';

import 'models/alma_module.dart';
import 'shell_modules.dart';

class AlmaShellPage extends StatefulWidget {
  const AlmaShellPage({super.key});

  @override
  State<AlmaShellPage> createState() => _AlmaShellPageState();
}

class _AlmaShellPageState extends State<AlmaShellPage> {
  int _selectedIndex = 0;

  List<AlmaModule> get _modules => almaModules;

  @override
  Widget build(BuildContext context) {
    final currentModule = _modules[_selectedIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(currentModule.title),
      ),
      body: Row(
        children: [

          // MENU
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.all,
            destinations: _modules
                .map(
                  (module) => NavigationRailDestination(
                    icon: Icon(module.icon),
                    label: Text(module.title),
                  ),
                )
                .toList(),
          ),

          const VerticalDivider(width: 1),

          Expanded(
            child: currentModule.page,
          ),
        ],
      ),
    );
  }
}