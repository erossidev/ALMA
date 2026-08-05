import '../brain_vocabulary.dart';
import '../protocol/brain_instruction.dart';

import 'knowledge_model.dart';


class BrainMapper {

  const BrainMapper();



  BrainInstruction map({

    required BrainOperation operation,

    required KnowledgeModel knowledge,

  }) {

    return BrainInstruction(

      operation: operation,

      entities: _mapEntities(
        knowledge,
      ),

      relations: _mapRelations(
        knowledge,
      ),

      facts: _mapFacts(
        knowledge,
      ),

    );

  }



  // =====================================================
  // FACT -> ENTITY
  // =====================================================


  List<BrainEntity> _mapFactEntities(
    KnowledgeModel knowledge,
  ) {

    final entities =
        <BrainEntity>[];


    for (final fact in knowledge.facts) {


      final id =
          fact.value
              .trim()
              .toLowerCase()
              .replaceAll(
                " ",
                "_",
              );


      entities.add(

        BrainEntity(

          id: id,

          label: fact.value,

          type: "concept",

        ),

      );

    }


    return entities;

  }





  // =====================================================
  // ENTITY
  // =====================================================

List<BrainEntity> _mapEntities(
  KnowledgeModel knowledge,
) {

  final entities =
      knowledge.entities.map(
    (entity) {

      print(
        "MAPPER ${entity.label} "
        "TYPE=${entity.type} "
        "SEMANTIC=${entity.semanticType}",
      );


      print(
        "BRAIN ENTITY CREATED "
        "${entity.label} -> ${entity.semanticType}",
      );


      return BrainEntity(

        id: entity.id,

        label: entity.label,


        // tipo strutturale del Brain
        type: "concept",


        // conoscenza imparata
        semanticType: entity.semanticType,

      );


    },
  ).toList();



  entities.addAll(
    _mapFactEntities(
      knowledge,
    ),
  );


  return entities;
}


  // =====================================================
  // RELATION
  // =====================================================


  List<BrainRelation> _mapRelations(

    KnowledgeModel knowledge,

  ) {


    final relations =

        knowledge.relations.map(

      (relation) {


        return BrainRelation(

          from: relation.from,

          to: relation.to,

          type: relation.type,

        );


      },

    ).toList();

print("===== MAPPER RELATIONS =====");

for (final r in knowledge.relations) {
  print(
    "${r.from} -> ${r.to} : ${r.type}",
  );
}

print("============================");


    relations.addAll(

      _mapFactRelations(
        knowledge,
      ),

    );



    return relations;

  }







  // =====================================================
  // FACT -> RELATION
  // =====================================================


  List<BrainRelation> _mapFactRelations(

    KnowledgeModel knowledge,

  ) {


    final relations =
        <BrainRelation>[];



    for (final fact in knowledge.facts) {


      final targetId =

          fact.value

              .trim()

              .toLowerCase()

              .replaceAll(
                " ",
                "_",
              );



      relations.add(

        BrainRelation(

          from: fact.entityId,

          to: targetId,

          type: fact.type,

        ),

      );


    }



    return relations;

  }







  // =====================================================
  // FACT
  // =====================================================


  List<BrainFact> _mapFacts(

    KnowledgeModel knowledge,

  ) {


    return knowledge.facts.map(

      (fact) {


        final type =
            fact.type.trim();



        return BrainFact(

          id: fact.id,

          entityId: fact.entityId,

          value: fact.value,

          type:
              FactType.values.firstWhere(

                (e) =>
                    e.name == type,

                orElse:
                    () =>
                        FactType.note,

              ),

        );


      },

    ).toList();

  }


}