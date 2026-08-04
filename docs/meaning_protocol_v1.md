# ALMA Meaning Protocol

**Version:** 1.0

## Purpose

The Meaning Protocol defines the semantic interface between a language
model and ALMA.

The language model is responsible only for understanding natural
language.

ALMA is responsible for understanding knowledge.

The protocol is intentionally independent from: - Brain -
KnowledgeModel - Firestore - Ontology - Neurons - Synapses

The protocol represents only the semantic meaning of the input sentence.

------------------------------------------------------------------------

# Design Principles

1.  The protocol must be model independent.
2.  The protocol must not contain Brain concepts.
3.  The protocol must never infer information.
4.  Every proposition must come directly from the sentence.
5.  The protocol describes meaning, not knowledge.
6.  Knowledge is built only by ALMA.

------------------------------------------------------------------------

# JSON Schema

``` json
{
  "version":"1.0",
  "entities":[
    {"id":"speaker","text":"io"},
    {"id":"e1","text":"Leila"}
  ],
  "propositions":[
    {
      "subject":"speaker",
      "predicate":"has daughter",
      "object":"e1"
    },
    {
      "subject":"e1",
      "predicate":"has age",
      "object":"12"
    }
  ]
}
```

------------------------------------------------------------------------

# Semantic Rules

## Entities

-   Only concepts explicitly mentioned.
-   IDs must be unique.
-   IDs are local to the document.
-   `speaker` identifies the current speaker.

## Propositions

-   Subject references an entity id.
-   Object references an entity id or literal value.
-   Predicates should be simple.
-   No ontology mapping.
-   No reasoning.
-   No inference.

------------------------------------------------------------------------

# Future Extensions

Version 2 - Events

Version 3 - Modifiers

Version 4 - Intent

------------------------------------------------------------------------

# Architectural Principle

The LLM understands language.

ALMA understands knowledge.

The Meaning Protocol is the only contract between them.
