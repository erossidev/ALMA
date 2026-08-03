import '../ai_task.dart';
import 'ai_configuration.dart';


class BackendAIConfiguration extends AIConfiguration {

  final Map<String, dynamic> routing;


  BackendAIConfiguration(
    this.routing,
  );


  @override
  String resourceFor(AITask task) {

    return routing[task.name]
        ??
        routing['dialogue']
        ??
        '';

  }
}