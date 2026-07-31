import '../brain.dart';
import '../synapse.dart';

class BrainRetriever {
  final Brain brain;

  const BrainRetriever(
    this.brain,
  );

  List<Synapse> retrieve(
    String query,
  ) {
    final q = query.toLowerCase();

    final results = <Synapse>[];

    for (final synapse in brain.synapses) {
      if (synapse.relationship.name
              .toLowerCase()
              .contains(q) ||
          synapse.from.label
              .toLowerCase()
              .contains(q) ||
          synapse.to.label
              .toLowerCase()
              .contains(q)) {
        results.add(synapse);
      }
    }

    return results;
  }
}