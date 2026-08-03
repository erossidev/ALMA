import 'package:flutter/material.dart';

import '../../../core/ai/ai_resource.dart';
import '../models/ai_routing_item.dart';

class RoutingItemCard extends StatelessWidget {
  final AIRoutingItem item;

  final List<AIResource> resources;

  final ValueChanged<String> onChanged;

  const RoutingItemCard({
    super.key,
    required this.item,
    required this.resources,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _taskTitle(item.task.name),
              style: Theme.of(context).textTheme.titleMedium,
            ),

            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              value: item.resourceId,

              decoration: const InputDecoration(
                labelText: 'AI Resource',
                border: OutlineInputBorder(),
              ),

              items: resources
                  .map(
                    (resource) => DropdownMenuItem<String>(
                      value: resource.id,
                      child: Text(resource.displayName),
                    ),
                  )
                  .toList(),

              onChanged: (value) {
                if (value != null) {
                  onChanged(value);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  String _taskTitle(String name) {
    switch (name) {
      case 'dialogue':
        return 'Dialogue';

      case 'knowledge':
        return 'Knowledge';

      case 'learning':
        return 'Learning';

      case 'reasoning':
        return 'Reasoning';

      case 'planning':
        return 'Planning';

      case 'coding':
        return 'Coding';

      case 'vision':
        return 'Vision';

      case 'emotion':
        return 'Emotion';

      case 'language':
        return 'Language';

      case 'ontologyNormalization':
        return 'Ontology';

      case 'tool':
        return 'Tools';

      default:
        return name;
    }
  }
}