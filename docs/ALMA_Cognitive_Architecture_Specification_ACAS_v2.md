# ALMA Cognitive Architecture Specification (ACAS)

Version: 2.0 (Draft)

## Manifesto

ALMA non distingue tra memoria e conoscenza.

Esiste un solo Brain.

La differenza non è dove vengono salvate le informazioni, ma il loro
ruolo cognitivo.

-   Il codice contiene il comportamento.
-   Il Brain contiene la conoscenza.
-   Ogni nuova conoscenza deve poter essere appresa senza modificare il
    codice sorgente.

------------------------------------------------------------------------

# Architettura Cognitiva

``` text
Brain
│
├── Semantic Cortex
│
├── Episodic Memory
│
├── Working Memory
│
├── Procedural Memory
│
└── Reasoner
```

## Semantic Cortex

È lo strato semantico del Brain.

Contiene:

-   Relationship Definitions
-   Entity Definitions
-   Fact Definitions
-   Concept Definitions
-   Rule Definitions
-   Attribute Definitions
-   Action Definitions
-   Ontology

Il Semantic Cortex rappresenta la conoscenza generale del sistema.

## Episodic Memory

Contiene le esperienze e i fatti conosciuti.

Esempi:

-   Emanuele worksAt MAB
-   Emanuele likes Pizza

## Working Memory

Contiene il contesto corrente della conversazione.

## Procedural Memory

Contiene le procedure e le strategie operative.

## Reasoner

Utilizza memoria e semantica per dedurre nuove informazioni.

------------------------------------------------------------------------

# Regola Fondamentale

Prima di aggiungere codice occorre chiedersi:

"Sto descrivendo comportamento o conoscenza?"

Se è comportamento → codice.

Se è conoscenza → Brain (Semantic Cortex).

------------------------------------------------------------------------

# Knowledge Objects

## RelationshipDefinition

Responsabilità:

-   identità
-   significato
-   dominio
-   range
-   cardinalità
-   regole
-   template di domanda
-   template di chiarimento
-   esempi
-   sinonimi
-   versioning

## EntityDefinition

Descrive le categorie di entità.

## FactDefinition

Descrive fatti complessi.

## ConceptDefinition

Descrive concetti astratti.

## RuleDefinition

Descrive regole logiche e semantiche.

## AttributeDefinition

Descrive attributi delle entità.

## ActionDefinition

Descrive azioni e verbi.

------------------------------------------------------------------------

# Bootstrap Cognitivo

Il Brain nasce con un vocabolario di base.

Il bootstrap:

1.  carica la conoscenza di sistema;
2.  costruisce il Semantic Cortex;
3.  rende disponibile il Brain.

------------------------------------------------------------------------

# Apprendimento

Flusso previsto:

Utente ↓ LLM ↓ Nuovo concetto ↓ Semantic Cortex ↓ Richiesta chiarimento
↓ Conferma utente ↓ Nuova definizione ↓ Persistenza

------------------------------------------------------------------------

# Principi Architetturali

1.  Un solo Brain.
2.  Un solo grafo della conoscenza.
3.  La semantica è conoscenza, non codice.
4.  Nessuna logica semantica hardcoded.
5.  Il Semantic Cortex è la fonte della verità.
6.  Le definizioni sono estendibili.
7.  L'apprendimento è incrementale.
8.  Il Brain può ragionare sia sui fatti sia sulla propria conoscenza.

------------------------------------------------------------------------

# Decisioni Architetturali Congelate

-   Brain unico.
-   Semantic Cortex interno al Brain.
-   Semantic Registry come API di accesso al Semantic Cortex.
-   Un unico grafo della conoscenza.
-   Separazione rigorosa tra comportamento e conoscenza.
-   Nessuna modifica al codice per apprendere nuovi concetti.

------------------------------------------------------------------------

# Stato della Progettazione

Completato:

-   Brain Engine
-   Execution Pipeline
-   Store
-   Replace
-   Visione del Semantic Cortex
-   Architettura cognitiva

Da progettare nei dettagli:

-   modello completo delle Definition
-   Similarity Engine
-   Learning Engine
-   Versioning semantico
-   Reasoning avanzato
-   gestione temporale della conoscenza

Questo documento rappresenta la base architetturale sulla quale
proseguirà lo sviluppo di ALMA.
