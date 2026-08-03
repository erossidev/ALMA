import 'backend_ai_registry.dart';
import 'ai_resource.dart';

class BackendAIService {
  BackendAIService({
    BackendAIRegistry? registry,
  }) : _registry = registry ?? BackendAIRegistry();

  final BackendAIRegistry _registry;

  Future<List<AIResource>> loadResources() {
    return _registry.loadResources();
  }

  Future<Map<String, dynamic>> loadRouting() {
    return _registry.loadRouting();
  }

  Future<void> saveRouting(
    Map<String, dynamic> routing,
  ) {
    return _registry.saveRouting(routing);
  }

  void clearCache() {
    _registry.clearCache();
  }
}