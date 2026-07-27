import 'models/dialogue_result.dart';

abstract class DialogueEngine {
  Future<DialogueResult> process({
    required String message,
  });
}