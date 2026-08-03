import 'ai_resource.dart';
import 'ai_task.dart';
import 'configuration/ai_configuration.dart';

class AIRouter {
  final AIConfiguration configuration;

  const AIRouter({
    required this.configuration,
  });

  AIResource route(
    AITask task,
    List<AIResource> resources,
  ) {
    final resourceId = configuration.resourceFor(task);

    return _find(
      resources,
      (r) => r.id == resourceId,
    );
  }

  AIResource _find(
    List<AIResource> resources,
    bool Function(AIResource) test,
  ) {
    for (final resource in resources) {
      if (test(resource)) {
        return resource;
      }
    }

    throw Exception(
      "Nessuna AI compatibile trovata.",
    );
  }
}