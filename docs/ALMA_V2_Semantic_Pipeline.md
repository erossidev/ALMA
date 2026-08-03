# ALMA V2 — Semantic Interpretation Pipeline

## Vision

The LLM is **not** responsible for building ALMA's internal knowledge.

Its role is only to understand natural language and expose its semantic meaning.

ALMA becomes the only component responsible for:

- Knowledge representation
- Ontology
- Neuron creation
- Synapse creation
- Identity resolution
- Conflict detection
- Clarification
- Memory

---

# Pipeline

User

↓

Natural Language

↓

LLM

↓

Semantic Meaning

↓

ALMA Meaning Interpreter

↓

Ontology Mapping

↓

Knowledge Model

↓

Brain Executor

↓

Neurons

↓

Synapses

↓

Memory

---

# Example

Sentence:

> Sono Manuel e ieri sono andato a Roma a vedere il concerto dei Queen.

## Phase 1 — LLM

The LLM returns semantic meaning only.

Example:

```json
{
  "propositions": [
    {
      "subject": "speaker",
      "predicate": "name",
      "object": "Manuel"
    },
    {
      "subject": "speaker",
      "predicate": "went_to",
      "object": "Rome",
      "time": "yesterday"
    },
    {
      "subject": "speaker",
      "predicate": "attended",
      "object": "Queen concert",
      "location": "Rome",
      "time": "yesterday"
    }
  ],
  "entities": [
    {
      "text":"Manuel",
      "kind":"person"
    },
    {
      "text":"Rome",
      "kind":"place"
    },
    {
      "text":"Queen",
      "kind":"music band"
    },
    {
      "text":"Queen concert",
      "kind":"event"
    }
  ]
}
```

Notice that the LLM **never** creates:

- IDs
- Ontology types
- Brain entities
- Neurons
- Synapses
- KnowledgeModel

It only explains what it understood.

---

# Phase 2 — ALMA Meaning Interpreter

ALMA reads the semantic representation.

Responsibilities:

- Resolve speaker → user
- Match existing entities
- Create missing entities
- Resolve aliases
- Consult ontology
- Map predicates
- Produce the internal KnowledgeModel

Example mappings:

name

↓

hasName

went_to

↓

visited

attended

↓

attendedEvent

---

# Phase 3 — Brain

Generated neurons

- User
- Manuel
- Rome
- Queen
- Queen Concert

Generated synapses

User
→ hasName
→ Manuel

User
→ visited
→ Rome

User
→ attendedEvent
→ Queen Concert

Queen Concert
→ performedBy
→ Queen

Queen Concert
→ locatedIn
→ Rome

Queen Concert
→ time
→ Yesterday

---

# Clarification

Clarification no longer depends on the LLM.

The Brain compares the new semantic information with existing knowledge.

Only ALMA decides whether a contradiction exists.

If necessary, ALMA asks the user for clarification.

---

# Why this architecture?

The LLM is extremely good at understanding language.

The Brain should be the only authority that decides how knowledge is represented.

This makes ALMA:

- independent from the LLM
- independent from prompt changes
- independent from ontology changes
- future-proof
- capable of evolving its own knowledge representation

---

# Core Principle

The LLM understands language.

ALMA understands knowledge.

The LLM interprets.

ALMA thinks.