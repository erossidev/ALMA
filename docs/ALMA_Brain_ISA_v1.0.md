# ALMA Brain ISA v1.0

## Definitive Specification

Version: 1.0

------------------------------------------------------------------------

# Purpose

The Brain ISA (Instruction Set Architecture) defines the only language
that can modify or query the Brain.

Every component of ALMA communicates with the Brain exclusively through
Brain ISA instructions.

The Brain never receives KnowledgeModel, Entity, Relation or Fact.

------------------------------------------------------------------------

# Architecture

Natural Language

↓

Knowledge Extraction

↓

KnowledgeModel

↓

Brain Importer

↓

Brain ISA

↓

Brain Memory Manager

↓

Brain

------------------------------------------------------------------------

# Fundamental Principles

1.  The Brain stores only Neurons and Synapses.
2.  Every instruction is atomic.
3.  An instruction performs exactly one operation.
4.  Instructions never call other instructions.
5.  Algorithms compose instructions.
6.  The Brain knows nothing about natural language.
7.  Semantic decisions belong to the Ontology.
8.  KnowledgeModel never reaches the Brain.

------------------------------------------------------------------------

# Instruction Result

Every instruction returns one of:

-   SUCCESS
-   NOT_FOUND
-   ALREADY_EXISTS
-   INVALID_ARGUMENT
-   FAILED

------------------------------------------------------------------------

# CORE ISA

## FindNeuron

Purpose: Search a neuron by id.

Input: - neuronId

Output: - FOUND - NOT_FOUND

No modification is performed.

------------------------------------------------------------------------

## CreateNeuron

Purpose: Create a neuron.

Input: - id - label - type

Precondition: Neuron must not exist.

Output: - SUCCESS - ALREADY_EXISTS

------------------------------------------------------------------------

## UpdateNeuron

Purpose: Update neuron metadata.

Allowed updates:

-   frequency
-   lastSeen

Output: - SUCCESS - NOT_FOUND

------------------------------------------------------------------------

## DeleteNeuron

Purpose: Remove a neuron.

Used only by Forgetting/Sleep.

Output: - SUCCESS - NOT_FOUND

------------------------------------------------------------------------

## FindSynapse

Purpose: Search a synapse.

Input:

-   source
-   relation
-   target

Output:

-   FOUND
-   NOT_FOUND

------------------------------------------------------------------------

## CreateSynapse

Purpose: Create a synapse.

Input:

-   source
-   relation
-   target

Precondition:

Both neurons already exist.

Output:

-   SUCCESS
-   ALREADY_EXISTS

------------------------------------------------------------------------

## UpdateSynapse

Purpose:

Update synapse metadata.

Allowed updates:

-   frequency
-   lastSeen

Output:

-   SUCCESS
-   NOT_FOUND

------------------------------------------------------------------------

## DeleteSynapse

Purpose:

Delete a synapse.

Used only by Forgetting/Sleep.

Output:

-   SUCCESS
-   NOT_FOUND

------------------------------------------------------------------------

# COGNITIVE ISA

These instructions are used by cognitive algorithms.

## ActivateNeuron

Activates one neuron.

Does not modify memory.

------------------------------------------------------------------------

## SpreadActivation

Propagates activation through connected synapses.

Does not modify memory.

------------------------------------------------------------------------

## ReinforceSynapse

Increases synaptic strength.

Used only during Sleep/Learning.

------------------------------------------------------------------------

## WeakenSynapse

Reduces synaptic strength.

Used only during Sleep.

------------------------------------------------------------------------

## DecayNeuron

Applies neuron decay.

------------------------------------------------------------------------

## DecaySynapse

Applies synapse decay.

------------------------------------------------------------------------

## ConsolidateNeuron

Consolidates neuron state.

------------------------------------------------------------------------

## ConsolidateSynapse

Consolidates synapse state.

------------------------------------------------------------------------

# Algorithm Composition

## STORE

FindNeuron

↓

CreateNeuron / UpdateNeuron

↓

FindSynapse

↓

CreateSynapse / UpdateSynapse

------------------------------------------------------------------------

## MERGE

FindNeuron

↓

UpdateNeuron

↓

FindSynapse

↓

UpdateSynapse

------------------------------------------------------------------------

## RETRIEVE

FindNeuron

↓

ActivateNeuron

↓

SpreadActivation

↓

FindSynapse

------------------------------------------------------------------------

## SLEEP

ReinforceSynapse

↓

WeakenSynapse

↓

DecayNeuron

↓

DecaySynapse

↓

DeleteSynapse

↓

DeleteNeuron

------------------------------------------------------------------------

# Brain Invariants

1.  Every neuron is unique.
2.  Every synapse connects two existing neurons.
3.  Duplicate synapses are forbidden.
4.  Instructions never interpret language.
5.  Algorithms never modify the Brain directly.
6.  Only Brain ISA instructions can access the Brain.
7.  STORE updates only frequency and lastSeen.
8.  Plasticity, weight, confidence and importance are modified only
    during Sleep.
9.  Questions never generate memory.
10. The Brain is language independent.

------------------------------------------------------------------------

# Open Topics

Future versions will define:

-   episodic memory
-   temporal memory
-   activation scoring
-   spreading activation algorithm
-   forgetting thresholds
-   consolidation formulas
-   reinforcement formulas

------------------------------------------------------------------------

# Final Vision

The Brain ISA is the contract between cognition and memory.

Knowledge Extraction transforms language into knowledge.

Brain Importer transforms knowledge into Brain instructions.

Brain Memory Manager executes Brain instructions.

The Brain stores only neurons and synapses.

Every future algorithm (STORE, MERGE, RETRIEVE, REASONING, LEARNING and
SLEEP) must be implemented exclusively by composing Brain ISA
instructions.
