import '../api/execution_plan.dart';
import '../brain_vocabulary.dart';

import '../instructions/ensure_neuron_instruction.dart';
import '../instructions/replace_relation_instruction.dart';
import '../instructions/store_neuron_instruction.dart';
import '../instructions/store_synapse_instruction.dart';

import '../neuron.dart';
import '../protocol/brain_instruction.dart';
import '../synapse.dart';



class ExecutionCompiler {

  const ExecutionCompiler();



  // ==========================================================
  // STORE
  // ==========================================================

  ExecutionPlan compileStore(
    BrainInstruction instruction,
  ) {

    final plan = ExecutionPlan();


    final neurons =
        <String, Neuron>{};



    // -----------------------------
    // Neuroni
    // -----------------------------

    for (final entity in instruction.entities) {


      print(
        "COMPILER ${entity.label} "
        "TYPE=${entity.type} "
        "SEMANTIC=${entity.semanticType}",
      );



      final neuron = Neuron(

        id: entity.id,

        label: entity.label,

        type: EntityType.concept,

        semanticType: entity.semanticType,

      );



      print(
        "NEURON CREATED "
        "${neuron.label} -> "
        "${neuron.type.name} "
        "semantic=${neuron.semanticType}",
      );



      neurons[entity.id] = neuron;



      plan.add(

        StoreNeuronInstruction(

          neuron: neuron,

        ),

      );

    }





    // -----------------------------
    // Neurone sistema
    // -----------------------------
    //
    // Il parser usa "speaker" per indicare
    // l'utente che parla.
    //
    // Nel Brain però l'entità reale è "user".
    //

    neurons["speaker"] = Neuron(

      id: "user",

      label: "Utente",

      type: EntityType.person,

      semanticType: "person",

    );





    // -----------------------------
    // Sinapsi
    // -----------------------------

    for (final relation in instruction.relations) {


      final fromId =
          relation.from == "speaker"
              ? "speaker"
              : relation.from;



      final from =
          neurons[fromId];



      final to =
          neurons[relation.to];



      if (from == null || to == null) {


        print(
          "SINAPSI SALTATA "
          "${relation.from} -> ${relation.to}",
        );


        continue;

      }





      final synapse = Synapse(


        id:
            "${relation.from}_${relation.type}_${relation.to}",


        from: from,


        to: to,


        relationship: relation.type,


      );



      print(

        "SINAPSI CREATA "
        "${synapse.from.label} "
        "-> "
        "${synapse.to.label} "
        "(${synapse.relationship})",

      );



      plan.add(


        StoreSynapseInstruction(


          synapse: synapse,


        ),


      );

    }



    return plan;

  }









  // ==========================================================
  // REPLACE
  // ==========================================================

  ExecutionPlan compileReplace(
    BrainInstruction instruction,
  ) {

    final plan = ExecutionPlan();


    final neurons =
        <String, Neuron>{};





    // -----------------------------
    // Assicura neuroni
    // -----------------------------

    for (final entity in instruction.entities) {


      print(
        "COMPILER REPLACE ${entity.label} "
        "TYPE=${entity.type} "
        "SEMANTIC=${entity.semanticType}",
      );



      final neuron = Neuron(

        id: entity.id,

        label: entity.label,

        type: EntityType.concept,

        semanticType: entity.semanticType,

      );



      neurons[entity.id] = neuron;



      plan.add(

        EnsureNeuronInstruction(

          neuron: neuron,

        ),

      );

    }





    // -----------------------------
    // Neurone sistema
    // -----------------------------

    neurons["speaker"] = Neuron(

      id: "user",

      label: "Utente",

      type: EntityType.person,

      semanticType: "person",

    );





    // -----------------------------
    // Sostituisce relazioni
    // -----------------------------

    for (final relation in instruction.relations) {


      final fromId =
          relation.from == "speaker"
              ? "speaker"
              : relation.from;



      final from =
          neurons[fromId];



      final to =
          neurons[relation.to];



      if (from == null || to == null) {


        print(
          "SINAPSI REPLACE SALTATA "
          "${relation.from} -> ${relation.to}",
        );


        continue;

      }




      final synapse = Synapse(


        id:
            "${relation.from}_${relation.type}_${relation.to}",


        from: from,


        to: to,


        relationship: relation.type,


      );



      plan.add(


        ReplaceRelationInstruction(


          synapse: synapse,


        ),


      );

    }



    return plan;

  }

}