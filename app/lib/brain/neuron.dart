import 'brain_vocabulary.dart';
import 'neuron_state.dart';


class Neuron {

  /// Identificatore univoco
  final String id;


  /// Etichetta leggibile
  final String label;


  /// Categoria interna del cervello
  final EntityType type;


  /// Significato imparato da Alma
  final String? semanticType;


  /// Descrizione opzionale
  String? description;


  /// Stato biologico del neurone
  final NeuronState state;



  Neuron({

    required this.id,

    required this.label,

    required this.type,

    this.semanticType,

    this.description,

    NeuronState? state,

  }) : state = state ?? NeuronState();




  Map<String, dynamic> toJson() {

    return {

      'id': id,

      'label': label,

      'type': type.name,

      'semanticType': semanticType,

      'description': description,

      'state': state.toJson(),

    };

  }





  factory Neuron.fromJson(

    Map<String, dynamic> json,

  ) {

    return Neuron(

      id: json['id'],

      label: json['label'],

      type: EntityType.values.firstWhere(

        (e) => e.name == json['type'],

        orElse: () => EntityType.unknown,

      ),

      semanticType: json['semanticType'],

      description: json['description'],

      state: NeuronState.fromJson(

        json['state'],

      ),

    );

  }

}