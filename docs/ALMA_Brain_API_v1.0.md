# ALMA Brain API v1.0

## Scopo

La Brain API definisce il contratto pubblico della Brain ISA.

Gli algoritmi (STORE, MERGE, RETRIEVE, SLEEP, REASONING...) possono
interagire con il Brain esclusivamente tramite queste API.

Le implementazioni possono cambiare. Le firme delle API devono rimanere
stabili.

------------------------------------------------------------------------

# Principi

-   Tutte le istruzioni sono atomiche.
-   Una istruzione = una responsabilità.
-   Nessuna istruzione richiama un'altra.
-   Nessuna istruzione interpreta il linguaggio naturale.
-   Tutte restituiscono un risultato standard.

------------------------------------------------------------------------

# InstructionResult

Ogni API restituisce:

-   SUCCESS
-   NOT_FOUND
-   ALREADY_EXISTS
-   INVALID_ARGUMENT
-   FAILED

------------------------------------------------------------------------

# Neuron API

## findNeuron(id)

Input: - neuronId

Output: - Neuron - NOT_FOUND

------------------------------------------------------------------------

## createNeuron(id, label, type)

Precondizioni: - il neurone non deve esistere

Output: - SUCCESS - ALREADY_EXISTS

------------------------------------------------------------------------

## updateNeuron(id, frequencyDelta, lastSeen)

Aggiorna esclusivamente: - frequency - lastSeen

------------------------------------------------------------------------

## deleteNeuron(id)

Usata solo dagli algoritmi di Forgetting/Sleep.

------------------------------------------------------------------------

# Synapse API

## findSynapse(sourceId, relationId, targetId)

Output: - Synapse - NOT_FOUND

------------------------------------------------------------------------

## createSynapse(sourceId, relationId, targetId)

Precondizioni: - entrambi i neuroni devono esistere

Output: - SUCCESS - ALREADY_EXISTS

------------------------------------------------------------------------

## updateSynapse(id, frequencyDelta, lastSeen)

Aggiorna esclusivamente: - frequency - lastSeen

------------------------------------------------------------------------

## deleteSynapse(id)

Usata solo da Forgetting/Sleep.

------------------------------------------------------------------------

# Cognitive API

## activateNeuron(id)

Attiva un neurone. Non modifica la memoria.

------------------------------------------------------------------------

## spreadActivation(startNeuronId)

Propaga l'attivazione lungo le sinapsi.

------------------------------------------------------------------------

## reinforceSynapse(id)

Incrementa il peso della sinapsi.

------------------------------------------------------------------------

## weakenSynapse(id)

Riduce il peso della sinapsi.

------------------------------------------------------------------------

## decayNeuron(id)

Applica il decadimento del neurone.

------------------------------------------------------------------------

## decaySynapse(id)

Applica il decadimento della sinapsi.

------------------------------------------------------------------------

## consolidateNeuron(id)

Consolida il neurone.

------------------------------------------------------------------------

## consolidateSynapse(id)

Consolida la sinapsi.

------------------------------------------------------------------------

# Chi utilizza queste API

Knowledge Extraction ↓ Brain Importer ↓ STORE MERGE RETRIEVE SLEEP
REASONING LEARNING ↓ Brain API ↓ Brain Memory Manager ↓ Brain

------------------------------------------------------------------------

# Regole

1.  Nessun algoritmo modifica direttamente il Brain.
2.  Tutti gli algoritmi usano esclusivamente la Brain API.
3.  La Brain API è l'unico punto di accesso alla memoria permanente.
4.  Neuroni e Sinapsi sono gli unici oggetti persistenti.
5.  Qualsiasi nuova funzionalità deve essere costruita componendo queste
    API.

------------------------------------------------------------------------

# Roadmap Implementativa

1.  Implementare Brain API Core.
2.  Rifattorizzare BrainMemoryManager per usare la Brain API.
3.  Implementare STORE v2.
4.  Implementare MERGE.
5.  Implementare RETRIEVE.
6.  Implementare SLEEP.
7.  Implementare REASONING.

Questo documento rappresenta il contratto tecnico ufficiale tra gli
algoritmi cognitivi e il Brain di ALMA.
