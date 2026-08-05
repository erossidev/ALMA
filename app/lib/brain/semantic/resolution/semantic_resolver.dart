import '../semantic_cortex.dart';
import '../semantic_node.dart';

import 'semantic_decision.dart';


class SemanticResolver {

  final SemanticCortex cortex;


  const SemanticResolver({
    required this.cortex,
  });



  Future<SemanticDecision> resolve(
    String entity,
  ) async {


    final normalized =
        _normalize(entity);



    final node =
        cortex.findByLabel(
          normalized,
        );



    if (node != null) {

      return SemanticDecision(

        entity: entity,

        known: true,

        semanticType:
            node.metadata.semanticType,

        brainType:
            node.metadata.brainType,

      );

    }



    return SemanticDecision(

      entity: entity,

      known: false,

      alternatives: const [],

    );

  }



  String _normalize(
    String value,
  ) {

    var result =
        value
            .toLowerCase()
            .trim();


    final prefixes = [
      "la stampante ",
      "il prodotto ",
      "la macchina ",
    ];


    for (final prefix in prefixes) {

      if (result.startsWith(prefix)) {

        result =
            result.substring(
              prefix.length,
            );

        break;
      }
    }


    return result;

  }

}