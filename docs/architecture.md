# ALMA Architecture

# Vision

ALMA (Adaptive Learning Memory Assistant) è un sistema cognitivo artificiale con memoria persistente.

Il suo obiettivo non è solamente generare risposte, ma costruire nel tempo una rappresentazione coerente della conoscenza dell'utente.

La conoscenza appartiene al Brain.

L'intelligenza appartiene ai modelli AI.

Il codice esegue e conserva la conoscenza.

---

# Obiettivi

- Memoria persistente
- Cognizione AI-Driven
- Multi AI
- Cloud Sync
- Privacy
- Modularità
- Espandibilità
- Indipendenza dal provider AI

---

# Architettura

Frontend (Flutter)

↓

Cognitive Engine

↓

Learning Pipeline

↓

Knowledge Pipeline

↓

AI Manager

↓

Brain Protocol

↓

Brain Executor

↓

Brain Memory Manager

↓

Brain Repository

↓

Cloud Database

---

# Componenti

## Frontend

Responsabilità

- UI
- Navigazione
- Esperienza utente

Non contiene logica AI.

Non contiene logica cognitiva.

---

## Cognitive Engine

Responsabilità

Coordinare l'intero ciclo cognitivo.

Gestisce:

- Percezione
- Memoria
- Recupero conoscenza
- Costruzione del contesto
- Apprendimento

È il cervello operativo di ALMA.

---

## AI Manager

Responsabilità

- selezionare il provider AI
- gestire OpenAI
- gestire Gemini
- gestire Claude
- gestire Ollama
- cambiare modello senza modificare il resto dell'app

Non salva dati.

Non interpreta memoria.

---

## Learning Pipeline

Responsabilità

Decidere se un messaggio contiene nuova conoscenza.

Produce una LearningDecision.

Non modifica il Brain.

---

## Knowledge Pipeline

Responsabilità

Comprendere il significato del messaggio.

Produrre una BrainInstruction.

Non modifica direttamente il Brain.

---

## Brain Protocol

Il Brain comunica esclusivamente tramite protocollo.

Ogni decisione viene rappresentata da una BrainInstruction.

Il protocollo definisce:

- operation
- memoryType
- confidence
- importance
- reason
- question
- entities
- relations
- facts

Il codice non interpreta il protocollo.

Lo esegue.

---

## Brain Executor

Responsabilità

Ricevere una BrainInstruction.

Instradare l'operazione corretta.

Operazioni supportate:

- store
- replace
- merge
- delete
- reinforce
- clarify
- ignore

---

## Brain

Il Brain rappresenta la memoria cognitiva di ALMA.

È composto da:

- neuroni
- sinapsi
- facts

Il Brain non prende decisioni.

Il Brain esegue istruzioni.

---

## Brain Memory Manager

Responsabilità

Aggiornare il Brain.

Creare neuroni.

Creare sinapsi.

Aggiornare la memoria.

Persistire le modifiche.

---

## Memory Retrieval

Responsabilità

Recuperare le parti del Brain rilevanti per una domanda.

Non interpreta la conoscenza.

Recupera solamente il sottografo utile.

---

## Context Builder

Responsabilità

Trasformare il sottografo recuperato
nel contesto da inviare al modello AI.

---

## Brain Repository

Responsabilità

Persistenza della memoria.

Salvataggio.

Caricamento.

Cloud Sync.

---

# Prompt

I prompt sono completamente modulari.

Ogni prompt possiede una sola responsabilità.

Attualmente il protocollo è composto da:

- BrainOutputPrompt
- BrainVocabularyPrompt
- BrainOperationPrompt
- BrainMemoryPrompt
- BrainEntityPrompt
- BrainRelationPrompt
- BrainFactPrompt
- BrainRulePrompt
- BrainExamplePrompt

---

# Flusso Cognitivo

Utente

↓

Cognitive Engine

↓

Learning Pipeline

↓

Knowledge Pipeline

↓

AI Manager

↓

BrainInstruction

↓

Brain Executor

↓

Brain Memory Manager

↓

Brain

↓

Brain Repository

↓

Memory Retrieval

↓

Context Builder

↓

AI Manager

↓

Risposta finale

---

# Principi Architetturali

## 1.

Il codice non interpreta mai la conoscenza.

---

## 2.

La conoscenza viene prodotta esclusivamente dall'AI.

---

## 3.

Il Brain esegue.

Non decide.

---

## 4.

Ogni classe possiede una sola responsabilità.

---

## 5.

Ogni componente comunica tramite protocollo.

Mai tramite logica implicita.

---

## 6.

Il parser valida solamente la struttura.

Non modifica il significato.

---

## 7.

Il codice non traduce valori.

Non corregge relazioni.

Non normalizza entità.

---

## 8.

Ogni decisione cognitiva appartiene al modello AI.

Store, Replace, Merge, Delete, Reinforce, Clarify e Ignore vengono sempre decisi dall'AI.

---

## 9.

La memoria è indipendente dal provider AI.

Qualunque modello compatibile deve poter guidare ALMA.

---

## 10.

I prompt sono modulari.

Ogni prompt descrive un solo aspetto del protocollo.

---

## 11.

Il Brain è un Knowledge Graph.

I neuroni rappresentano entità.

Le sinapsi rappresentano relazioni.

I facts rappresentano proprietà.

---

## 12.

La memoria deve evolvere nel tempo.

Il Brain non è un database.

È un sistema cognitivo persistente che apprende, consolida e aggiorna la propria conoscenza.