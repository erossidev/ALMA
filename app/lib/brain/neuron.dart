import 'brain_vocabulary.dart';
import 'neuron_state.dart';

class Neuron {
  /// Identificatore univoco
  final String id;

  /// Etichetta leggibile
  final String label;

  /// Tipo semantico del neurone
  final EntityType type;

  /// Descrizione opzionale
  String? description;

  /// Stato biologico del neurone
  final NeuronState state;

  Neuron({
    required this.id,
    required this.label,
    required this.type,
    this.description,
    NeuronState? state,
  }) : state = state ?? NeuronState();

  // ==========================================================
  // SERIALIZZAZIONE
  // ==========================================================

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'label': label,
      'type': type.name,
      'description': description,
      'state': state.toJson(),
    };
  }

  // ==========================================================
  // DESERIALIZZAZIONE
  // ==========================================================

  factory Neuron.fromJson(
    Map<String, dynamic> json,
  ) {
    return Neuron(
      id: json['id'],
      label: json['label'],
      type: EntityType.values.firstWhere(
        (e) => e.name == json['type'],
      ),
      description: json['description'],
      state: NeuronState.fromJson(
        json['state'],
      ),
    );
  }
}
