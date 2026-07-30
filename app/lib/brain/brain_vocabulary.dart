/// ==========================================================
/// ALMA BRAIN VOCABULARY
///
/// Vocabolario semantico ufficiale del Brain.
///
/// Tutto il progetto deve usare ESCLUSIVAMENTE
/// questi tipi e queste relazioni.
///
/// Qualsiasi LLM deve tradurre il linguaggio naturale
/// in questo vocabolario.
///
/// ==========================================================

/// ==========================================================
/// ENTITY TYPES
/// ==========================================================

enum EntityType {
  // Persone
  person,

  // Animali
  animal,

  // Luoghi
  place,

  // Organizzazioni
  organization,
  company,

  // Oggetti
  project,
  product,
  technology,
  document,

  // Tempo
  date,
  event,

  // Astratti
  concept,
  preference,
  goal,
  emotion,

  // Fallback
  unknown,
}

/// ==========================================================
/// RELATIONSHIP TYPES
/// ==========================================================

enum RelationshipType {
  // ========================================================
  // IDENTITÀ
  // ========================================================

  hasName,
  hasNickname,

  // ========================================================
  // FAMIGLIA
  // ========================================================

  spouse,

  hasFather,
  hasMother,

  hasBrother,
  hasSister,

  hasSon,
  hasDaughter,

  // ========================================================
  // BIOGRAFIA
  // ========================================================

  birthDate,
  birthPlace,

  livesIn,
  worksAt,
  studiedAt,

  // ========================================================
  // POSSESSO
  // ========================================================

  owns,
  hasPet,

  // ========================================================
  // PREFERENZE
  // ========================================================

  likes,
  dislikes,

  loves,
  hates,

  // ========================================================
  // TECNOLOGIA
  // ========================================================

  uses,
  createdBy,

  // ========================================================
  // GENERICHE
  // ========================================================

  relatedTo,
}

/// ==========================================================
/// RELATIONSHIP CARDINALITY
/// ==========================================================

enum RelationshipCardinality {
  single,
  multiple,
}

class RelationshipDefinition {
  final RelationshipType type;
  final RelationshipCardinality cardinality;

  const RelationshipDefinition({
    required this.type,
    required this.cardinality,
  });
}


/// ==========================================================
/// FACT TYPES
///
/// Attributi di una singola entità.
/// Non rappresentano connessioni.
/// ==========================================================

enum FactType {
  birthday,

  age,

  email,

  phone,

  website,

  nationality,

  language,

  profession,

  gender,

  note,
}

/// ==========================================================
/// DERIVED FACTS
///
/// NON vengono memorizzati.
///
/// Sono calcolati automaticamente
/// a partire da altre informazioni.
///
/// ==========================================================

enum DerivedFactType {
  age,

  yearsOfMarriage,

  yearsOfWork,

  daysUntilBirthday,

  zodiacSign,
}

/// ==========================================================
/// VOCABULARY HELPERS
/// ==========================================================

class BrainVocabulary {
  const BrainVocabulary._();

  static const Map<RelationshipType, RelationshipDefinition>
    relationshipDefinitions = {
  // Identità
  RelationshipType.hasName: RelationshipDefinition(
    type: RelationshipType.hasName,
    cardinality: RelationshipCardinality.single,
  ),
  RelationshipType.hasNickname: RelationshipDefinition(
    type: RelationshipType.hasNickname,
    cardinality: RelationshipCardinality.multiple,
  ),

  // Famiglia
  RelationshipType.spouse: RelationshipDefinition(
    type: RelationshipType.spouse,
    cardinality: RelationshipCardinality.single,
  ),
  RelationshipType.hasFather: RelationshipDefinition(
    type: RelationshipType.hasFather,
    cardinality: RelationshipCardinality.single,
  ),
  RelationshipType.hasMother: RelationshipDefinition(
    type: RelationshipType.hasMother,
    cardinality: RelationshipCardinality.single,
  ),
  RelationshipType.hasBrother: RelationshipDefinition(
    type: RelationshipType.hasBrother,
    cardinality: RelationshipCardinality.multiple,
  ),
  RelationshipType.hasSister: RelationshipDefinition(
    type: RelationshipType.hasSister,
    cardinality: RelationshipCardinality.multiple,
  ),
  RelationshipType.hasSon: RelationshipDefinition(
    type: RelationshipType.hasSon,
    cardinality: RelationshipCardinality.multiple,
  ),
  RelationshipType.hasDaughter: RelationshipDefinition(
    type: RelationshipType.hasDaughter,
    cardinality: RelationshipCardinality.multiple,
  ),

  // Biografia
  RelationshipType.birthDate: RelationshipDefinition(
    type: RelationshipType.birthDate,
    cardinality: RelationshipCardinality.single,
  ),
  RelationshipType.birthPlace: RelationshipDefinition(
    type: RelationshipType.birthPlace,
    cardinality: RelationshipCardinality.single,
  ),
  RelationshipType.livesIn: RelationshipDefinition(
    type: RelationshipType.livesIn,
    cardinality: RelationshipCardinality.single,
  ),
  RelationshipType.worksAt: RelationshipDefinition(
    type: RelationshipType.worksAt,
    cardinality: RelationshipCardinality.single,
  ),
  RelationshipType.studiedAt: RelationshipDefinition(
    type: RelationshipType.studiedAt,
    cardinality: RelationshipCardinality.multiple,
  ),

  // Possesso
  RelationshipType.owns: RelationshipDefinition(
    type: RelationshipType.owns,
    cardinality: RelationshipCardinality.multiple,
  ),
  RelationshipType.hasPet: RelationshipDefinition(
    type: RelationshipType.hasPet,
    cardinality: RelationshipCardinality.multiple,
  ),

  // Preferenze
  RelationshipType.likes: RelationshipDefinition(
    type: RelationshipType.likes,
    cardinality: RelationshipCardinality.multiple,
  ),
  RelationshipType.dislikes: RelationshipDefinition(
    type: RelationshipType.dislikes,
    cardinality: RelationshipCardinality.multiple,
  ),
  RelationshipType.loves: RelationshipDefinition(
    type: RelationshipType.loves,
    cardinality: RelationshipCardinality.multiple,
  ),
  RelationshipType.hates: RelationshipDefinition(
    type: RelationshipType.hates,
    cardinality: RelationshipCardinality.multiple,
  ),

  // Tecnologia
  RelationshipType.uses: RelationshipDefinition(
    type: RelationshipType.uses,
    cardinality: RelationshipCardinality.multiple,
  ),
  RelationshipType.createdBy: RelationshipDefinition(
    type: RelationshipType.createdBy,
    cardinality: RelationshipCardinality.single,
  ),

  // Generiche
  RelationshipType.relatedTo: RelationshipDefinition(
    type: RelationshipType.relatedTo,
    cardinality: RelationshipCardinality.multiple,
  ),
};

static bool isSingleRelation(
  RelationshipType relation,
) {
  return relationshipDefinitions[relation]!
          .cardinality ==
      RelationshipCardinality.single;
}

  static bool isFamilyRelation(
    RelationshipType relation,
  ) {
    switch (relation) {
      case RelationshipType.spouse:
      case RelationshipType.hasFather:
      case RelationshipType.hasMother:
      case RelationshipType.hasBrother:
      case RelationshipType.hasSister:
      case RelationshipType.hasSon:
      case RelationshipType.hasDaughter:
        return true;

      default:
        return false;
    }
  }

  static bool isBiographicalRelation(
    RelationshipType relation,
  ) {
    switch (relation) {
      case RelationshipType.birthDate:
      case RelationshipType.birthPlace:
      case RelationshipType.livesIn:
      case RelationshipType.worksAt:
      case RelationshipType.studiedAt:
        return true;

      default:
        return false;
    }
  }

  static bool isPreferenceRelation(
    RelationshipType relation,
  ) {
    switch (relation) {
      case RelationshipType.likes:
      case RelationshipType.dislikes:
      case RelationshipType.loves:
      case RelationshipType.hates:
        return true;

      default:
        return false;
    }
  }

  static bool isDerivedFact(
    DerivedFactType fact,
  ) {
    switch (fact) {
      case DerivedFactType.age:
      case DerivedFactType.yearsOfMarriage:
      case DerivedFactType.yearsOfWork:
      case DerivedFactType.daysUntilBirthday:
      case DerivedFactType.zodiacSign:
        return true;
    }
  }
}