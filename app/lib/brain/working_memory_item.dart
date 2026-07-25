import 'neuron.dart';

class WorkingMemoryItem {
  final Neuron neuron;

  double activation;

  DateTime lastUpdate;

  WorkingMemoryItem({
    required this.neuron,
    this.activation = 1.0,
    DateTime? lastUpdate,
  }) : lastUpdate = lastUpdate ?? DateTime.now();

  void reinforce([double amount = 0.1]) {
    activation += amount;

    if (activation > 1.0) {
      activation = 1.0;
    }

    lastUpdate = DateTime.now();
  }

  void decay([double amount = 0.05]) {
    activation -= amount;

    if (activation < 0.0) {
      activation = 0.0;
    }

    lastUpdate = DateTime.now();
  }
}