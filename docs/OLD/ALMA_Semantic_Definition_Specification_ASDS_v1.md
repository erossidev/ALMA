# ALMA Semantic Definition Specification (ASDS)

Version: 1.0 (Draft)

## Visione

Il Semantic Registry è l'unica fonte di verità della conoscenza
semantica di ALMA. Nessuna conoscenza semantica deve essere hardcoded
nel codice.

Regole: - Nessuno `switch` su relazioni o tipi. - Nessun `if` basato su
identificativi semantici. - Tutti i componenti interrogano il Semantic
Registry.

------------------------------------------------------------------------

# Architettura

``` text
SemanticBootstrap
        │
        ▼
SemanticRegistry
        │
        ├── RelationshipDefinitions
        ├── EntityDefinitions
        ├── FactDefinitions
        └── (future) ActionDefinitions
```

Componenti che consultano il Registry:

-   BrainMapper
-   BrainClarifier
-   ConflictDetector
-   Reasoner
-   Prompt Builder
-   UI
-   Memory Engine

------------------------------------------------------------------------

# RelationshipDefinition

## Identità

-   id
-   displayName
-   description
-   aliases

## Semantica

-   domain
-   range
-   parent
-   children
-   synonyms
-   antonyms
-   examples
-   counterExamples

## Regole

-   singleValue
-   allowMultiple
-   replaceStrategy
-   editable
-   learnable
-   required

## Conversazione

-   question
-   clarificationTemplate
-   confirmationTemplate
-   helpText

## Evoluzione

-   source
-   confidence
-   version
-   createdAt
-   updatedAt
-   createdBy

------------------------------------------------------------------------

# EntityDefinition

## Identità

-   id
-   displayName
-   description

## Semantica

-   parent
-   children
-   synonyms
-   attributes

## Regole

-   editable
-   learnable

## Evoluzione

-   source
-   version
-   createdAt
-   updatedAt

------------------------------------------------------------------------

# FactDefinition

Un Fact rappresenta una conoscenza composta.

Campi:

-   id
-   displayName
-   description
-   requiredRelations
-   optionalRelations
-   validationRules

------------------------------------------------------------------------

# Semantic Registry

Responsabilità:

-   registrare definizioni
-   recuperarle
-   aggiornarle
-   esporle ai componenti del Brain

Non deve conoscere Firestore, JSON o assets.

------------------------------------------------------------------------

# Semantic Bootstrap

Responsabilità:

-   caricare il vocabolario di base
-   leggere gli assets
-   leggere eventuali definizioni apprese
-   popolare il Semantic Registry

------------------------------------------------------------------------

# Flusso di apprendimento

``` text
Utente
   │
   ▼
LLM
   │
   ▼
BrainMapper
   │
   ▼
SemanticRegistry
   │
   ├── trovato
   │      ▼
   │   usa la definizione
   │
   └── non trovato
          ▼
Similarity Engine
          ▼
Richiesta di chiarimento
          ▼
Nuova RelationshipDefinition
          ▼
SemanticRegistry
          ▼
Persistenza
```

------------------------------------------------------------------------

# Principi architetturali

1.  La semantica non vive nel codice.
2.  Le definizioni sono dati, non enum.
3.  Tutti i componenti interrogano il Registry.
4.  Il Bootstrap carica, il Registry serve.
5.  Le definizioni possono evolvere senza ricompilare ALMA.
6.  Ogni concetto è versionabile.
7.  L'apprendimento è incrementale.

------------------------------------------------------------------------

# Roadmap

## Fase 1

-   SemanticRegistry
-   RelationshipDefinition
-   EntityDefinition
-   FactDefinition
-   Bootstrap

## Fase 2

-   Assets semantici
-   Integrazione con BrainMapper
-   Clarifier basato sul Registry

## Fase 3

-   Similarity Engine
-   Auto-apprendimento
-   Versioning
-   Persistenza

## Obiettivo finale

ALMA deve poter apprendere nuovi concetti, relazioni ed entità senza
modificare il codice sorgente. Il Semantic Registry rappresenta il
vocabolario vivente del sistema.
