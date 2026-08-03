import 'ai_configuration.dart';
import 'ai_configuration_repository.dart';
import 'default_ai_configuration.dart';

class MemoryAIConfigurationRepository
    implements AIConfigurationRepository {

  MemoryAIConfigurationRepository._();

  static final MemoryAIConfigurationRepository _instance =
      MemoryAIConfigurationRepository._();

  factory MemoryAIConfigurationRepository() {
    return _instance;
  }

  AIConfiguration _configuration =
      defaultAIConfiguration;

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