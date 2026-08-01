class SemanticMetadata {
  String? displayName;

  String? description;

  String? source;

  double confidence;

  SemanticMetadata({
    this.displayName,
    this.description,
    this.source,
    this.confidence = 1.0,
  });
}