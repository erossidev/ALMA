class KnowledgeEntity {

  final String id;

  final String label;


  // Tipo ontologico
  final String type;


  // Tipo trovato dalla memoria semantica ALMA
  final String? semanticType;


  const KnowledgeEntity({
    required this.id,
    required this.label,
    required this.type,
    this.semanticType,
  });



  KnowledgeEntity copyWith({

    String? id,

    String? label,

    String? type,

    String? semanticType,

  }) {

    return KnowledgeEntity(

      id: id ?? this.id,

      label: label ?? this.label,

      type: type ?? this.type,

      semanticType:
          semanticType ?? this.semanticType,

    );

  }

}