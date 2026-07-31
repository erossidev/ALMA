class OntologyRules {
  const OntologyRules._();

  /// L'id di una relazione non cambia mai.
  static const immutableIds = true;

  /// Le relazioni devono appartenere ad una categoria.
  static const requireCategory = true;

  /// Ogni relazione deve avere una descrizione.
  static const requireDescription = true;

  /// Ogni relazione può avere alias.
  static const enableAliases = true;

  /// Ogni relazione può avere esempi.
  static const enableExamples = true;

  /// Le relazioni possono avere una relazione inversa.
  static const enableInverse = true;

  /// Le relazioni possono essere modificate nel tempo.
  static const enableMutable = true;

  /// L'Ontology può crescere.
  static const learningEnabled = true;
}