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

  Map<String, dynamic> toJson() {
  return {
    'id': id,
    'label': label,
    'type': type.name,
    'description': description,
    'state': state.toJson(),
  };
}

factory Neuron.fromJson(Map<String, dynamic> json) {
  return Neuron(
    id: json['id'],
    label: json['label'],
    type: NodeType.values.firstWhere(
      (e) => e.name == json['type'],
    ),
    description: json['description'],
    state: NeuronState.fromJson(json['state']),
  );
}
}

