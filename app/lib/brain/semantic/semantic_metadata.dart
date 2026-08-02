class SemanticMetadata {

  /// Nome leggibile
  String? displayName;

  /// Descrizione del concetto
  String? description;

  /// Provenienza della conoscenza
  String? source;

  /// Affidabilità
  double confidence;

  /// Parole chiave associate
  List<String> keywords;

  /// Sinonimi / nomi alternativi
  List<String> aliases;

  SemanticMetadata({
    this.displayName,
    this.description,
    this.source,
    this.confidence = 1.0,
    List<String>? keywords,
    List<String>? aliases,
  })  : keywords = keywords ?? [],
        aliases = aliases ?? [];

}