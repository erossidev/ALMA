import '../semantic_cortex.dart';
import '../semantic_node.dart';

import 'similarity_candidate.dart';
import 'similarity_request.dart';
import 'similarity_result.dart';

/// ===============================
/// CONFIGURAZIONE
/// ===============================

const double _labelWeight = 1.0;
const double _aliasWeight = 0.8;
const double _keywordWeight = 0.5;

const double _minimumScore = 0.5;
const int _maxResults = 3;

/// ===============================
/// NORMALIZZAZIONE TESTO
/// ===============================

String _normalize(
  String value,
) {
  return value
      .toLowerCase()
      .trim()
      .replaceAll(
        RegExp(r'[^\w\s]'),
        '',
      )
      .replaceAll(
        RegExp(r'\s+'),
        ' ',
      );
}

/// ===============================
/// CALCOLO SCORE
/// ===============================

double _calculateScore(
  SimilarityRequest request,
  SemanticNode node,
) {
  double score = 0;

  final text = _normalize(
    "${request.entity} ${request.context}",
  );

  // --------------------------
  // LABEL
  // --------------------------

  if (text.contains(
    _normalize(node.label),
  )) {
    score += _labelWeight;
  }

  // --------------------------
  // KEYWORDS
  // --------------------------

  for (final keyword in node.metadata.keywords) {
    if (text.contains(
      _normalize(keyword),
    )) {
      score += _keywordWeight;
    }
  }

  // --------------------------
  // ALIAS
  // --------------------------

  for (final alias in node.metadata.aliases) {
    if (text.contains(
      _normalize(alias),
    )) {
      score += _aliasWeight;
    }
  }

  return score;
}

/// ===============================
/// ORDINAMENTO
/// ===============================

List<SimilarityCandidate> _sortCandidates(
  List<SimilarityCandidate> candidates,
) {
  candidates.sort(
    (a, b) => b.score.compareTo(a.score),
  );

  return candidates;
}

/// ===============================
/// ENGINE
/// ===============================

class SimilarityEngine {
  final SemanticCortex cortex;

  const SimilarityEngine({
    required this.cortex,
  });

  Future<SimilarityResult> classify(
    SimilarityRequest request,
  ) async {
    final candidates = <SimilarityCandidate>[];

    for (final node in cortex.nodes) {
      final score = _calculateScore(
        request,
        node,
      );

      if (score >= _minimumScore) {
        candidates.add(
          SimilarityCandidate(
            node: node,
            score: score,
          ),
        );
      }
    }

    final sorted =
        _sortCandidates(candidates);

    return SimilarityResult(
      candidates:
          sorted.take(_maxResults).toList(),
    );
  }
}