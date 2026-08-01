# ALMA Brain Algorithms v1.0

## 1. Filosofia

Il Brain di ALMA è un grafo cognitivo.

La memoria permanente contiene esclusivamente: - Neuroni - Sinapsi

Il Brain non conosce Entity, Relation o Fact. Questi sono modelli
temporanei utilizzati esclusivamente durante l'elaborazione.

------------------------------------------------------------------------

## 2. Flusso Cognitivo

Utente → Planner → KnowledgeModel → BrainImporter → STORE/MERGE → Brain
→ RETRIEVE → Reasoning → Language → Risposta

------------------------------------------------------------------------

## 3. KnowledgeModel

Formato temporaneo di scambio tra AI e Brain.

Contiene: - Entities - Relations - Facts

Non viene mai salvato nel Brain.

------------------------------------------------------------------------

## 4. Brain

### Neuroni

Rappresentano le entità.

### Sinapsi

Collegano due neuroni.

------------------------------------------------------------------------

## 5. STORE

1.  Creare o recuperare i neuroni.
2.  Creare o recuperare le sinapsi.
3.  Aggiornare:
    -   frequency
    -   lastSeen
4.  Non modificare:
    -   plasticity
    -   weight
    -   confidence

------------------------------------------------------------------------

## 6. MERGE

-   Non creare duplicati.
-   Aggiornare frequency.
-   Aggiornare lastSeen.

------------------------------------------------------------------------

## 7. Ontologia

L'ontologia decide: - concept ID; - sinonimi; - normalizzazione; -
entity o primitive.

Lo STORE consulta sempre l'ontologia.

------------------------------------------------------------------------

## 8. RETRIEVE

Domanda → Parser → Concetti → Ontologia → Attivazione → Espansione →
Contesto → LLM → Risposta

------------------------------------------------------------------------

## 9. SLEEP

Aggiorna: - plasticity - weight - confidence - importance

------------------------------------------------------------------------

## 10. CLARIFICATION

Le informazioni in conflitto non vengono salvate fino alla risposta
dell'utente.

------------------------------------------------------------------------

## 11. Regole Fondamentali

1.  Solo Neuroni e Sinapsi nel Brain.
2.  KnowledgeModel temporaneo.
3.  STORE non interpreta.
4.  Ontologia guida la semantica.
5.  Le domande non generano memoria.
6.  Retrieval prima della risposta.
7.  Il sonno consolida.

------------------------------------------------------------------------

## 12. Brain Invariants

1.  Il Brain è un grafo.
2.  Ogni neurone è unico.
3.  Ogni sinapsi collega due neuroni.
4.  Nessuna sinapsi duplicata.
5.  Il Brain non interpreta il linguaggio.
6.  L'ontologia è l'autorità semantica.
7.  STORE aggiorna solo frequency e lastSeen.
8.  SLEEP aggiorna plasticity, weight, confidence, importance e decay.
9.  Le domande non generano memoria.
10. Ogni risposta nasce dalla memoria.
11. Il Brain è indipendente dalla lingua.
12. KnowledgeModel è temporaneo.
13. Ogni modifica passa dagli algoritmi ufficiali.

------------------------------------------------------------------------

## 13. Regola Fondamentale

L'architettura del Brain è congelata.

------------------------------------------------------------------------

## 14. Principi di Progettazione

1.  Prima l'algoritmo, poi il codice.
2.  L'architettura è immutabile.
3.  L'ontologia è il vocabolario universale.
4.  La memoria è indipendente dalla AI.
5.  Un algoritmo, una responsabilità.
6.  Nessuna logica semantica nel Brain.
7.  Nessuna regola hardcoded.
8.  Comportamento deterministico.
9.  Nessuna memoria persa durante una conversazione.
10. Il Brain è il centro del sistema.

------------------------------------------------------------------------

## 15. Visione Finale

ALMA è un sistema cognitivo con una memoria permanente basata su neuroni
e sinapsi.

L'intelligenza nasce dagli algoritmi del Brain e dalla qualità delle
connessioni costruite nel tempo.
