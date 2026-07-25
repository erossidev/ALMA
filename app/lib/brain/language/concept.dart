import '../neuron.dart';
import '../brain_vocabulary.dart';

class Concept {
  final String id;

  final String label;

  final EntityType type;

  const Concept({
    required this.id,
    required this.label,
    required this.type,
  });
}