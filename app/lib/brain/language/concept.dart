import '../neuron.dart';

class Concept {
  final String id;

  final String label;

  final NodeType type;

  const Concept({
    required this.id,
    required this.label,
    required this.type,
  });
}