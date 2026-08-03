import '../ai_task.dart';

import 'ai_configuration.dart';
import 'ai_configuration_repository.dart';

class InMemoryAIConfigurationRepository
    implements AIConfigurationRepository {
  AIConfiguration _configuration = AIConfiguration(
    routing: {
      for (final task in AITask.values) task: 'backend',
    },
  );

  @override
  Future<AIConfiguration> load() async {
    return _configuration;
  }

  @override
  Future<void> save(
    AIConfiguration configuration,
  ) async {
    _configuration = configuration;
  }
}