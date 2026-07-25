import 'neuron_state.dart';

enum NodeType {
  person,
  project,
  technology,
  place,
  event,
  preference,
  goal,
  concept,
  emotion,
}

class Neuron {
  final String id;
  final String label;
  final NodeType type;

  String? description;

  final NeuronState state;

  Neuron({
    required this.id,
    required this.label,
    required this.type,
    this.description,
    NeuronState? state,
  }) : state = state ?? NeuronState();
}