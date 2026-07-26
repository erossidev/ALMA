import 'dart:convert';

import '../brain_vocabulary.dart';

import 'brain_instruction.dart';


class BrainInstructionParser {
  const BrainInstructionParser();


  BrainInstruction parse(
    String json,
  ) {

    final Map<String, dynamic> data =
        jsonDecode(json);


    return BrainInstruction(

      version:
          data['version'] ?? 1,


      operation:
          _parseOperation(
        data['operation'],
      ),


      memoryType:
          _parseMemoryType(
        data['memoryType'],
      ),


      confidence:
          (data['confidence'] ?? 1.0)
              .toDouble(),


      importance:
          (data['importance'] ?? 1.0)
              .toDouble(),


      reason:
          data['reason'],

      question:
          data['question'],


      entities:
          _parseEntities(
        data['entities'],
      ),


      relations:
          _parseRelations(
        data['relations'],
      ),


      facts:
          _parseFacts(
        data['facts'],
      ),

    );
  }



  // =====================================================
  // ENUM
  // =====================================================

  BrainOperation _parseOperation(
    String? value,
  ) {

    return BrainOperation.values.firstWhere(
      (e) => e.name == value,
      orElse: () => BrainOperation.ignore,
    );
  }



  MemoryType _parseMemoryType(
    String? value,
  ) {

    return MemoryType.values.firstWhere(
      (e) => e.name == value,
      orElse: () => MemoryType.semantic,
    );
  }





  // =====================================================
  // ENTITIES
  // =====================================================

  List<BrainEntity> _parseEntities(
    dynamic list,
  ) {

    if (list is! List) {
      return [];
    }


    return list.map(
      (item) {

        return BrainEntity(

          id:
              item['id'],

          label:
              item['label'],

          type:
              _parseEntityType(
            item['type'],
          ),

        );

      },
    ).toList();
  }





  // =====================================================
  // RELATIONS
  // =====================================================

  List<BrainRelation> _parseRelations(
    dynamic list,
  ) {

    if (list is! List) {
      return [];
    }


    return list.map(
      (item) {

        return BrainRelation(

          from:
              item['from'],

          to:
              item['to'],

          type:
              _parseRelation(
            item['type'],
          ),

        );

      },
    ).toList();
  }





  // =====================================================
  // FACTS
  // =====================================================

  List<BrainFact> _parseFacts(
    dynamic list,
  ) {

    if (list is! List) {
      return [];
    }


    return list.map(
      (item) {

        return BrainFact(

          id:
              item['id'],

          entityId:
              item['entityId'],

          type:
              _parseFactType(
            item['type'],
          ),

          value:
              item['value'],

        );

      },
    ).toList();
  }





  // =====================================================
  // VOCABULARY
  // =====================================================

  EntityType _parseEntityType(
    String? value,
  ) {

    return EntityType.values.firstWhere(
      (e) => e.name == value,
      orElse: () => EntityType.concept,
    );
  }




  RelationshipType _parseRelation(
    String? value,
  ) {

    return RelationshipType.values.firstWhere(
      (e) => e.name == value,
      orElse: () => RelationshipType.relatedTo,
    );
  }




  FactType _parseFactType(
    String? value,
  ) {

    return FactType.values.firstWhere(
      (e) => e.name == value,
      orElse: () => FactType.note,
    );
  }
}