import '../../../core/ai/configuration/ai_configuration.dart';
import '../../../core/ai/configuration/ai_configuration_repository.dart';

class AIRoutingService {
  final AIConfigurationRepository _repository;

  const AIRoutingService({
    required AIConfigurationRepository repository,
  }) : _repository = repository;

  Future<AIConfiguration> load() {
    return _repository.load();
  }

  Future<void> save(AIConfiguration configuration) {
    return _repository.save(configuration);
  }
}