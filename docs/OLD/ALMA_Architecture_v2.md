# ALMA Architecture

Version: 2.0 (Unified Draft)

## Vision

ALMA (Adaptive Learning Memory Assistant) è un'architettura cognitiva
progettata per costruire e mantenere una rappresentazione persistente
della conoscenza dell'utente e del mondo.

L'intelligenza appartiene ai modelli AI. La conoscenza appartiene al
Brain. Il codice coordina, valida ed esegue i protocolli.

## Obiettivi

-   Memoria persistente
-   Comprensione del dialogo
-   Cognizione AI-driven
-   Multi AI
-   Indipendenza dai provider
-   Modularità
-   Espandibilità
-   Privacy

## Principi Architetturali

1.  Il codice non interpreta mai la conoscenza.
2.  Le decisioni cognitive appartengono ai modelli AI.
3.  Il Brain conserva la conoscenza, non prende decisioni.
4.  Il Dialogue Engine mantiene il contesto della conversazione.
5.  Ogni componente ha una sola responsabilità.
6.  I componenti comunicano tramite protocolli espliciti.
7.  La memoria è indipendente dal provider AI.
8.  L'architettura deve essere estendibile.

## Architettura

Utente ↓ Dialogue Engine ↓ Cognitive Engine ↓ Learning Engine ↓
Knowledge Engine ↓ Brain Protocol ↓ Brain Executor ↓ Brain ↓ Memory
Retrieval ↓ Context Builder ↓ AI Orchestrator ↓ Provider AI ↓ Risposta

## Componenti

### Dialogue Engine

-   Comprende il dialogo nel contesto.
-   Gestisce Pending Interaction.
-   Mantiene il Dialogue State.

### Dialogue State

Contiene: - Pending Interaction - Current Topic - Current Intent -
Recent Topics

### Pending Interaction

Tipi: - Clarification - Confirmation - Choice - Follow-up -
Disambiguation

### Cognitive Engine

Coordina il ciclo cognitivo.

### Learning Engine

Decide se apprendere.

### Knowledge Engine

Estrae la conoscenza.

### Brain Protocol

Definisce store, merge, replace, delete, reinforce, clarify e ignore.

### Brain

Knowledge Graph composto da Neurons, Synapses e Facts.

### Brain Executor

Esegue le BrainInstruction.

### Memory Retrieval

Recupera il sottografo rilevante.

### Context Builder

Costruisce il contesto per i modelli AI.

### AI Orchestrator

Seleziona dinamicamente la migliore risorsa AI e gestisce il fallback.

## Flusso Cognitivo

Utente ↓ Dialogue Engine ↓ Dialogue Classification ↓ Interaction
Resolution ↓ Learning Engine ↓ Knowledge Engine ↓ Brain Protocol ↓ Brain
Executor ↓ Brain ↓ Memory Retrieval ↓ Context Builder ↓ AI Orchestrator
↓ Provider AI ↓ Risposta

## Evoluzione

-   Theory of Self
-   Memoria episodica
-   Memoria semantica
-   Pianificazione
-   Ragionamento
-   Emozioni
-   Selezione dinamica dei modelli AI

## Regola d'oro

Il Dialogue Engine comprende il contesto. Il Brain conserva la
conoscenza. L'AI prende le decisioni cognitive. Il codice coordina ed
esegue.
