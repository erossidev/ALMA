import 'semantic_node.dart';

class SemanticCortex {
  final Map<String, SemanticNode> _nodes = {};

  /// ==========================
  /// GETTERS
  /// ==========================

  Iterable<SemanticNode> get nodes =>
      _nodes.values;

  int get nodeCount =>
      _nodes.length;

  /// ==========================
  /// REGISTRAZIONE
  /// ==========================

  void register(
    SemanticNode node,
  ) {
    _nodes[node.id] = node;
  }

  /// ==========================
  /// RICERCA
  /// ==========================

  bool contains(
    String id,
  ) {
    return _nodes.containsKey(id);
  }

  SemanticNode? getNode(
    String id,
  ) {
    return _nodes[id];
  }

  SemanticNode? findByLabel(
    String label,
  ) {
    try {
      return _nodes.values.firstWhere(
        (node) =>
            node.label.toLowerCase() ==
            label.toLowerCase(),
      );
    } catch (_) {
      return null;
    }
  }
}