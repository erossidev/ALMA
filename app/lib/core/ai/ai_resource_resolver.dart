import 'ai_request.dart';
import 'ai_resource.dart';

class AIResourceResolver {
  const AIResourceResolver();

  List<AIResource> resolveCandidates({
    required AIRequest request,
    required List<AIResource> resources,
  }) {
    final compatible = resources.where((resource) {
      if (!resource.enabled) {
        return false;
      }

      return request.requiredCapabilities.every(
        resource.capabilities.contains,
      );
    }).toList();

    compatible.sort(
      (a, b) => a.priority.compareTo(b.priority),
    );

    return compatible;
  }
}