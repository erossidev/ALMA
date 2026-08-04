# ALMA V2 – Cognitive Architecture Specification

## Scopo

Trasformare ALMA in un **Brain indipendente dagli LLM**.

L'LLM interpreta il linguaggio.
ALMA comprende, organizza e memorizza la conoscenza.

---

# Principi fondamentali

1. L'LLM non costruisce il Brain.
2. Il Brain è l'unica autorità sulla conoscenza.
3. L'ontologia appartiene ad ALMA.
4. Neuroni e sinapsi sono l'unica memoria persistente.
5. Ogni decisione cognitiva deve essere presa dal Brain quando possibile.

---

# Nuova pipeline

```text
Utente
    │
Planner
    │
Perception
    │
Dialogue
    │
Meaning Extraction (LLM)
    │
MeaningModel
    │
Meaning Interpreter
    │
KnowledgeModel
    │
BrainMapper
    │
BrainInstruction
    │
BrainExecutor
    │
BrainMemoryManager
    │
Firestore
```

---

# MeaningModel

Il MeaningModel è il contratto universale tra qualsiasi LLM e ALMA.

Contiene esclusivamente il significato linguistico:

- entities
- propositions
- modifiers
- temporal context
- spatial context
- confidence

Non contiene:

- ID dei neuroni
- sinapsi
- riferimenti a Firestore
- KnowledgeModel
- BrainInstruction

---

# Meaning Interpreter

È il cuore cognitivo di ALMA.

## Moduli

- Reference Resolver
- Entity Resolver
- Similarity Engine
- Ontology Resolver
- Conflict Analyzer
- Clarification Engine
- Knowledge Builder
- BrainMapper

## Responsabilità

- risolvere speaker, lei, lui, esso...
- cercare entità esistenti
- proporre possibili corrispondenze
- consultare l'ontologia
- costruire il KnowledgeModel
- preparare le BrainInstruction

---

# KnowledgeModel

È una rappresentazione cognitiva costruita esclusivamente da ALMA.

Da questo punto in poi nessun componente dipende più dal linguaggio naturale.

---

# Brain

Rimangono invariati:

- BrainInstruction
- BrainExecutor
- BrainMemoryManager

Il Brain continua a memorizzare esclusivamente neuroni e sinapsi.

---

# Migrazione V1 → V2

1. Knowledge Extraction → Meaning Extraction
2. Introduzione del MeaningModel
3. Introduzione del Meaning Interpreter
4. Eliminazione progressiva della normalizzazione ontologica basata su LLM
5. Ontology Resolver deterministico
6. BrainMapper, BrainInstruction e BrainExecutor rimangono quasi invariati

---

# Visione finale

L'LLM comprende il linguaggio.

ALMA comprende la conoscenza.

Le responsabilità cognitive appartengono esclusivamente al Brain:

- identità delle entità
- risoluzione delle ambiguità
- applicazione dell'ontologia
- creazione di neuroni
- creazione di sinapsi
- clarification
- semantic learning
