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
/// FACT TYPES
///
/// Attributi di una singola entità.
/// Non rappresentano connessioni.
/// ==========================================================

enum FactType {
  birthday,

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