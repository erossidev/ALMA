# ALMA Architecture

## Vision

ALMA (Adaptive Learning Memory Assistant) è un assistente AI con memoria persistente, capace di utilizzare diversi modelli di intelligenza artificiale e sincronizzare la conoscenza nel cloud.

---

# Obiettivi

- Memoria persistente
- Multi AI
- Cloud Sync
- Privacy
- Modularità
- Espandibilità

---

# Architettura

Frontend (Flutter)
↓

Backend API

↓

AI Manager
Memory Engine
Storage Service

↓

Cloud Database

---

# Componenti

## Frontend

Responsabilità:

- UI
- Navigazione
- Esperienza utente

Non contiene logica AI.

---

## AI Manager

Responsabilità:

- scegliere il provider AI
- gestire OpenAI
- gestire Gemini
- gestire Claude
- gestire Ollama
- cambiare modello senza modificare il resto dell'app

Non salva dati.

---

## Memory Engine

Responsabilità:

- creare ricordi
- aggiornare ricordi
- recuperare ricordi
- collegare informazioni

Non comunica direttamente con l'utente.

---

## Storage Service

Responsabilità:

- salvataggio locale
- sincronizzazione cloud
- cache offline

---

## Settings Service

Responsabilità:

- tema
- lingua
- provider AI
- modello predefinito
- preferenze utente

---

# Flusso di una conversazione

Utente

↓

Chat Page

↓

AI Manager

↓

Provider AI

↓

Risposta

↓

Memory Engine

↓

Storage Service

↓

Cloud

---

# Principi

Ogni classe ha una sola responsabilità.

Le feature non comunicano direttamente tra loro.

Ogni comunicazione passa attraverso servizi dedicati.

L'app non dipende mai da un singolo provider AI.

La memoria è indipendente dal modello AI.