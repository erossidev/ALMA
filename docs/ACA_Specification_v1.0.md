# ACA -- ALMA Cognitive Architecture Specification

**Versione:** 1.0

## Visione

ALMA è un'architettura cognitiva personale. Non memorizza semplicemente
dati: costruisce una rete di conoscenza che evolve con l'esperienza.

## Principi fondamentali

1.  La conoscenza è una rete.
2.  Il concetto fondamentale è il Neuron.
3.  Le relazioni sono Synapse.
4.  L'apprendimento modifica continuamente la rete.
5.  Il recupero della memoria avviene tramite propagazione
    dell'attivazione.
6.  Firestore è memoria persistente, non il cervello.

## Componenti

### Brain

Contiene e orchestra la rete cognitiva.

### Neuron

Rappresenta un concetto.

### NeuronState

Stato dinamico del neurone: - activation - importance - confidence -
plasticity - emotionalWeight - activationCount - lastActivated

Metodi: - activate() - decay() - reinforce() - weaken() -
consolidate() - forget()

### Synapse

Connessione tra due neuroni.

Metodi: - activate() - strengthen() - weaken() - consolidate() - decay()

### Working Memory

Memoria della conversazione corrente.

### Hippocampus

Decide cosa consolidare nella memoria permanente.

### Cognitive Engine

Coordina tutti gli organi cognitivi.

## Ciclo cognitivo

Utente → Comprensione → Working Memory → Hippocampus → Brain →
Aggiornamento Neuron/Synapse → Risposta

## Legge di Hebb

Neuroni che si attivano insieme rafforzano la loro connessione.

## Plasticità

La plasticità determina la velocità di apprendimento e non raggiunge mai
zero.

## Consolidamento

L'attivazione non implica apprendimento. Il consolidamento è una
decisione dell'Hippocampus.

## Dimenticanza

Le conoscenze decadono gradualmente e possono diventare dormienti.

## Theory of Self (roadmap)

ALMA distinguerà: - conoscenza del mondo - conoscenza dell'utente -
conoscenza di sé

## Regola d'oro

Il modello cognitivo guida il codice. Mai il contrario.
