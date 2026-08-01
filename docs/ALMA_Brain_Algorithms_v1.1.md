# ALMA Brain Algorithms v1.1

## 1. Filosofia

Il Brain di ALMA è un grafo cognitivo.

La memoria permanente contiene esclusivamente: - Neuroni - Sinapsi

Ogni neurone e ogni sinapsi possiedono proprietà (frequency, weight,
plasticity, confidence, ecc.).

Entity, Relation e Fact sono modelli temporanei utilizzati solo durante
l'elaborazione.

------------------------------------------------------------------------

## 2. Flusso Cognitivo

Utente → Planner → Knowledge Extraction → KnowledgeModel → Brain
Importer → STORE / MERGE → Brain → RETRIEVE → Reasoning → Language →
Risposta

------------------------------------------------------------------------

## 3. KnowledgeModel

Formato temporaneo di comunicazione tra AI e Brain.

Contiene: - Entities - Relations - Facts

Non viene mai salvato nel Brain.

------------------------------------------------------------------------

## 4. Brain

### Neuroni

Rappresentano le entità.

### Sinapsi

Collegano due neuroni tramite una relazione.

------------------------------------------------------------------------

## 5. STORE

1.  Crea o recupera i neuroni.
2.  Crea o recupera le sinapsi.
3.  Aggiorna solo:
    -   frequency
    -   lastSeen
4.  Non aggiorna:
    -   plasticity
    -   weight
    -   confidence
    -   importance

------------------------------------------------------------------------

## 6. MERGE

Se il neurone o la sinapsi esistono già:

-   non creare duplicati;
-   incrementare frequency;
-   aggiornare lastSeen.

------------------------------------------------------------------------

## 7. Ontologia

L'ontologia è il vocabolario concettuale di ALMA.

Determina:

-   concept ID;
-   sinonimi;
-   normalizzazione;
-   se un Fact rappresenta una nuova entità oppure un valore primitivo.

Lo STORE non prende decisioni semantiche.

------------------------------------------------------------------------

## 8. RETRIEVE

Domanda → Parser → Estrazione concetti → Normalizzazione tramite
ontologia → Attivazione neuroni → Espansione sinapsi → Costruzione
contesto → LLM → Risposta

------------------------------------------------------------------------

## 9. SLEEP

Durante il sonno vengono aggiornati:

-   plasticity
-   weight
-   confidence
-   importance
-   decay

Lo STORE non modifica questi valori.

------------------------------------------------------------------------

## 10. CLARIFICATION

Le informazioni in conflitto non vengono salvate.

Prima viene richiesta una chiarificazione all'utente.

------------------------------------------------------------------------

## 11. Regole Fondamentali

1.  Il Brain contiene solo Neuroni e Sinapsi.
2.  Il KnowledgeModel è temporaneo.
3.  Lo STORE non interpreta il significato.
4.  L'ontologia guida tutte le decisioni semantiche.
5.  Le domande non generano memoria.
6.  Il Retrieval precede la risposta.
7.  Il sonno consolida il Brain.

------------------------------------------------------------------------

## 12. Brain Invariants

1.  Il Brain è un grafo.
2.  Ogni neurone è unico.
3.  Ogni sinapsi collega due neuroni esistenti.
4.  Non possono esistere sinapsi duplicate.
5.  Il Brain non interpreta il linguaggio.
6.  L'ontologia è l'autorità semantica.
7.  STORE aggiorna solo frequency e lastSeen.
8.  Solo SLEEP modifica plasticity, weight, confidence, importance e
    decay.
9.  Le domande non generano memoria.
10. Ogni risposta nasce dal recupero della memoria.
11. Il Brain è indipendente dalla lingua.
12. Il KnowledgeModel non viene mai salvato.
13. Ogni modifica passa dagli algoritmi ufficiali.

------------------------------------------------------------------------

## 13. Regola Fondamentale

L'architettura del Brain è congelata.

Ogni nuova funzionalità deve adattarsi al Brain.

------------------------------------------------------------------------

## 14. Principi di Progettazione

1.  Prima l'algoritmo, poi il codice.
2.  L'architettura è immutabile.
3.  L'ontologia è il vocabolario universale.
4.  La memoria è indipendente dal modello AI.
5.  Ogni algoritmo ha una sola responsabilità.
6.  Nessuna logica semantica nel Brain.
7.  Nessuna regola hardcoded.
8.  Comportamento deterministico.
9.  Nessuna memoria viene eliminata durante una conversazione.
10. Il Brain è il centro del sistema.

------------------------------------------------------------------------

## 15. Visione Finale

ALMA è un sistema cognitivo.

La sua memoria permanente è composta esclusivamente da neuroni e
sinapsi.

L'intelligenza deriva dagli algoritmi del Brain e non dal modello
linguistico.

------------------------------------------------------------------------

## 16. Knowledge Extraction v2

### Scopo

Trasformare un messaggio dell'utente in un KnowledgeModel completo senza
perdere informazioni esplicite.

### Pipeline

Messaggio

↓

Sentence Splitter

↓

Entity Extraction

↓

Action Extraction

↓

Relation Extraction

↓

Fact Extraction

↓

Ontology Mapping

↓

KnowledgeModel

### Step 1 - Sentence Splitter

Divide il messaggio in frasi indipendenti.

### Step 2 - Entity Extraction

Estrae tutte le entità nominate.

Non crea relazioni.

### Step 3 - Action Extraction

Estrae tutti i verbi che rappresentano informazioni.

Ogni verbo deve essere conservato.

### Step 4 - Relation Extraction

Trasforma ogni azione in una relazione.

Non utilizza ancora i concept ID.

### Step 5 - Fact Extraction

Estrae tutti i valori primitivi.

### Step 6 - Ontology Mapping

Normalizza tipi e relazioni utilizzando l'ontologia.

Non crea nuova conoscenza.

### Step 7 - KnowledgeModel Assembly

Costruisce il KnowledgeModel finale.

------------------------------------------------------------------------

### Invarianti della Knowledge Extraction

1.  Nessuna entità può andare persa.
2.  Nessuna azione può andare persa.
3.  Nessuna deduzione è consentita.
4.  Una frase può produrre più relazioni.
5.  L'ontologia normalizza ma non inventa conoscenza.
6.  Il Brain riceve sempre un KnowledgeModel completo.

### Punto aperto

La rappresentazione di tempo ed episodi (oggi, ieri, domani, settimana
scorsa, ecc.) sarà definita durante la progettazione della memoria
episodica.
