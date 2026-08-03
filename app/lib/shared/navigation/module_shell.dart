import 'package:flutter/material.dart';

import 'navigation_item.dart';

class ModuleShell<T extends NavigationItem> extends StatefulWidget {
  final String title;
  final Widget? header;
  final List<T> items;

  const ModuleShell({
    super.key,
    required this.title,
    required this.items,
    this.header,
  });

  @override
  State<ModuleShell<T>> createState() => _ModuleShellState<T>();
}

class _ModuleShellState<T extends NavigationItem>
    extends State<ModuleShell<T>> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final currentItem = widget.items[_selectedIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            labelType: NavigationRailLabelType.all,
            onDestinationSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            destinations: widget.items
                .map(
                  (item) => NavigationRailDestination(
                    icon: Icon(item.icon),
                    label: Text(item.title),
                  ),
                )
                .toList(),
          ),

          const VerticalDivider(width: 1),

          Expanded(
            child: Column(
              children: [
                if (widget.header != null) widget.header!,

                Expanded(
                  child: currentItem.page,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}