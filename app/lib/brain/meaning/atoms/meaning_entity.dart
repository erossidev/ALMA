import 'meaning_semantic.dart';


class MeaningEntity {


  final String id;


  final String text;


  /// Categoria estratta dal linguaggio
  /// esempio:
  /// Ender -> stampante
  /// XENOFIL -> materiale
  final String? type;


  final MeaningSemantic? semantic;



  const MeaningEntity({

    required this.id,

    required this.text,

    this.type,

    this.semantic,

  });


}