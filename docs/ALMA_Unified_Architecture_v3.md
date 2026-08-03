# ALMA Unified Architecture Specification (Draft v3)

## 1. Vision

ALMA is a cognitive architecture, not a chatbot. The Brain is the single
cognitive center, while AI models are interchangeable advisors.
Permanent knowledge is represented as a cognitive graph composed only of
neurons and synapses.

## 2. Architectural Principles

-   One Brain coordinates cognition.
-   Semantic Cortex is the single source of structured knowledge.
-   Behavior belongs in code; knowledge belongs in the Brain.
-   LLMs propose; ALMA decides.
-   No semantic logic is hardcoded.
-   Components have a single responsibility.
-   Dependency Injection is preferred.
-   Refactor incrementally.

## 3. Cognitive Architecture

Brain - Semantic Cortex - Episodic Memory - Working Memory - Procedural
Memory - Reasoner

## 4. Brain Model

Persistent objects: - Neuron - Synapse

Temporary objects: - KnowledgeModel - Entity - Relation - Fact

KnowledgeModel never reaches persistent storage.

## 5. Ontology

The Ontology defines relations, concepts, aliases, normalization rules
and language evolution. Unknown relations trigger clarification and
learning instead of invention.

## 6. Standard Cognitive Pipeline

User → Dialogue → Planner → Knowledge Extraction → KnowledgeModel →
Ontology Mapping → Brain Importer → Brain ISA → Brain Memory Manager →
Brain → Retrieval → Context Builder → AI Orchestrator → Response

## 7. Brain ISA

Only Brain ISA instructions can modify/query the Brain. Core groups: -
Neuron (find/create/update/delete) - Synapse
(find/create/update/delete) - Cognitive (activate, spread, reinforce,
weaken, decay, consolidate)

Algorithms (STORE, MERGE, RETRIEVE, SLEEP, REASONING, LEARNING) are
compositions of ISA instructions.

## 8. Brain API

Stable public contract exposing Brain ISA. No algorithm accesses the
Brain directly.

## 9. Knowledge Extraction

Pipeline: Sentence Splitter → Entity Extraction → Action Extraction →
Relation Extraction → Fact Extraction → Ontology Mapping →
KnowledgeModel

No deduction is allowed during extraction.

## 10. AI Engine

Modules: - Provider Registry - Provider Catalog - AI Manager - AI
Orchestrator - AI Router - AI Configuration - AI Telemetry - AI
Execution History

Providers are configurable and interchangeable.

## 11. AI Center

Planned UI: - Dashboard - Routing - Models - Providers - Telemetry -
History - Costs - Limits - Benchmarks - Insights

## 12. Roadmap

Completed: - Infrastructure - Brain foundations - Cognitive
integration - AI architecture

Next: 1. Dialogue Engine 2. Cognitive Memory 3. Conversation History 4.
Episodic Memory 5. Propagation Engine 6. Theory of Self 7. AI Center 8.
Persistent AI configuration (Isar/Firebase)

## 13. Frozen Decisions

-   One Brain.
-   One knowledge graph.
-   Brain stores only neurons and synapses.
-   Ontology is the semantic authority.
-   Brain ISA is the only memory interface.
-   AI models never write knowledge directly.
-   Knowledge grows without changing source code.
