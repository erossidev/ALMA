# ALMA -- Architectural Rules

Version: 1.0

## Purpose

This document defines the architectural rules that every module of ALMA
must follow.

------------------------------------------------------------------------

# Rule 1 -- The Brain is the Cognitive Center

The Brain is the central coordinator of ALMA.

-   Coordinates Memory
-   Coordinates Semantic Cortex
-   Coordinates Learning
-   Coordinates Reasoning
-   Maintains cognitive state

No specialized module makes cognitive decisions independently.

------------------------------------------------------------------------

# Rule 2 -- Standard AI Pipeline

Every AI cognitive module follows:

``` text
Request
    ↓
Prompt
    ↓
AIManager
    ↓
JSON
    ↓
Parser
    ↓
Domain Object
    ↓
Engine
```

Responsibilities:

-   Request: context
-   Prompt: communication with AI
-   AIManager: model abstraction
-   Parser: JSON → objects
-   Domain Object: typed result
-   Engine: decisions

------------------------------------------------------------------------

# Rule 3 -- LLMs Never Modify Knowledge Directly

AI models may suggest or classify.

Only ALMA can transform a proposal into permanent knowledge.

------------------------------------------------------------------------

# Rule 4 -- Semantic Cortex Is the Single Source of Structured Knowledge

The Semantic Cortex stores:

-   entities
-   relations
-   ontology
-   learned concepts

------------------------------------------------------------------------

# Rule 5 -- AI Proposes, ALMA Decides

``` text
Unknown Entity
      ↓
SemanticLearningEngine
      ↓
SemanticAdvisor
      ↓
AI Suggestion
      ↓
User Confirmation
      ↓
Semantic Cortex
```

Without confirmation (or explicit system rules), proposals are not
stored.

------------------------------------------------------------------------

# Rule 6 -- Single Responsibility

Each component has one clear responsibility.

------------------------------------------------------------------------

# Rule 7 -- Dependency Injection

Components receive collaborators through constructors.

------------------------------------------------------------------------

# Rule 8 -- Incremental Refactoring

Small change. Compile. Green. Next step.

------------------------------------------------------------------------

# Vision

ALMA is a cognitive architecture.

-   Brain coordinates cognition.
-   Semantic Cortex stores knowledge.
-   Engines reason and learn.
-   AI models are interchangeable advisors.
