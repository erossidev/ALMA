enum SemanticRelationType {
  // Gerarchia
  isA,
  parentOf,
  childOf,

  // Associazione
  relatedTo,
  similarTo,
  oppositeOf,

  // Definizione
  defines,
  describes,
  explains,

  // Semantica
  domain,
  range,

  // Linguaggio
  synonymOf,
  aliasOf,

  // Organizzazione
  belongsTo,
  contains,

  // Ereditarietà
  inheritsFrom,
}