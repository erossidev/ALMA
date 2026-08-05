import '../api/instruction.dart';
import '../api/instruction_result.dart';
import '../context/brain_context.dart';
import '../neuron.dart';


class StoreNeuronInstruction extends BrainInstruction {

  final Neuron neuron;


  const StoreNeuronInstruction({
    required this.neuron,
  });



  @override
  Future<InstructionResult<void>> execute(
    BrainContext context,
  ) async {


    final existing =
        context.brain.getNeuron(
          neuron.id,
        );


    // ===============================
    // NUOVO NEURONE
    // ===============================

    if (existing == null) {

      context.brain.addNeuron(
        neuron,
      );


      await context.repository.saveNeuron(
        neuron,
      );


      print(
        ">>> NUOVO NEURONE SALVATO "
        "${neuron.label}",
      );

    }


    // ===============================
    // AGGIORNAMENTO
    // ===============================

    else {


      final updated = Neuron(

        id: existing.id,

        label: neuron.label,

        type: neuron.type,

        semanticType:
            neuron.semanticType,

        description:
            neuron.description,

        state:
            existing.state,

      );



      context.brain.updateNeuron(
        updated,
      );


      await context.repository.saveNeuron(
        updated,
      );


      print(
        ">>> NEURONE AGGIORNATO "
        "${updated.label} "
        "semantic=${updated.semanticType}",
      );

    }



    return InstructionResult.success();

  }

}