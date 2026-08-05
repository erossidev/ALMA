class SemanticLearningRequest {

  final String entity;

  final String text;

  final String? type;


  const SemanticLearningRequest({

    required this.entity,

    required this.text,

    this.type,

  });

}