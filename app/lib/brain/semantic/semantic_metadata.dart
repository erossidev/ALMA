class SemanticMetadata {

  String? displayName;

  String? description;

  String? source;

  double confidence;

  List<String> keywords;

  List<String> aliases;

  String? semanticType;

  String? brainType;


  SemanticMetadata({
    this.displayName,
    this.description,
    this.source,
    this.confidence = 1.0,
    this.semanticType,
    this.brainType,
    List<String>? keywords,
    List<String>? aliases,
  })  : keywords = keywords ?? [],
        aliases = aliases ?? [];
}