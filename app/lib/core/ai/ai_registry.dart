import 'ai_resource.dart';

abstract class AIRegistry {

  Future<List<AIResource>> loadResources();

}