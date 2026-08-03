import 'ai_configuration.dart';

abstract class AIConfigurationRepository {
  Future<AIConfiguration> load();

  Future<void> save(
    AIConfiguration configuration,
  );
}