const gemini = require("../providers/gemini");
const groq = require("../providers/groq");
const openrouter = require("../providers/openrouter");
const ollama = require("../providers/ollama");

module.exports = [

  // =====================================================
  // OPENROUTER
  // =====================================================

  {
    id: "openrouter",
    name: "OpenRouter",
    enabled: true,
    handler: openrouter,

    resources: [

      {
        id: "openrouter_auto",
        modelId: "openrouter/auto",
        displayName: "OpenRouter Auto",
        priority: 3,
        capabilities: [
          "conversation",
          "reasoning",
          "json",
          "coding"
        ]
      },

      {
        id: "openrouter_gpt5",
        modelId: "openai/gpt-5",
        displayName: "GPT-5",
        priority: 1,
        capabilities: [
          "conversation",
          "reasoning",
          "json",
          "coding"
        ]
      },

      {
        id: "openrouter_gpt5mini",
        modelId: "openai/gpt-5-mini",
        displayName: "GPT-5 Mini",
        priority: 2,
        capabilities: [
          "conversation",
          "reasoning",
          "json"
        ]
      }

    ]
  },

  // =====================================================
  // GEMINI
  // =====================================================

  {
    id: "gemini",
    name: "Gemini",
    enabled: true,
    handler: gemini,

    resources: [

      {
        id: "gemini_flash",
        modelId: "gemini-2.5-flash",
        displayName: "Gemini 2.5 Flash",
        priority: 1,
        capabilities: [
          "conversation",
          "reasoning",
          "json",
          "vision"
        ]
      }

    ]
  },

  // =====================================================
  // GROQ
  // =====================================================

  {
    id: "groq",
    name: "Groq",
    enabled: true,
    handler: groq,

    resources: [

      {
        id: "groq_gptoss120b",
        modelId: "openai/gpt-oss-120b",
        displayName: "GPT OSS 120B",
        priority: 1,
        capabilities: [
          "conversation",
          "reasoning",
          "json",
          "coding",
          "planning",
          "knowledge"
        ]
      },

      {
        id: "groq_qwen27b",
        modelId: "qwen/qwen3-32b",
        displayName: "Qwen 3 32B",
        priority: 2,
        capabilities: [
          "conversation",
          "reasoning",
          "knowledge",
          "learning",
          "ontology",
          "json"
        ]
      },

      {
        id: "groq_llama70b",
        modelId: "llama-3.3-70b-versatile",
        displayName: "Llama 3.3 70B",
        priority: 3,
        capabilities: [
          "conversation",
          "reasoning",
          "emotion",
          "json"
        ]
      },

      {
        id: "groq_gptoss20b",
        modelId: "openai/gpt-oss-20b",
        displayName: "GPT OSS 20B",
        priority: 4,
        capabilities: [
          "conversation",
          "json"
        ]
      }

    ]
  },

  // =====================================================
  // OLLAMA
  // =====================================================

  {
    id: "ollama",
    name: "Ollama",
    enabled: true,
    handler: ollama,

    resources: [

      {
        id: "ollama_qwen3",
        modelId: "qwen2.5:3b",
        displayName: "Qwen 2.5 3B",
        priority: 1,
        capabilities: [
          "conversation",
          "reasoning",
          "json",
          "knowledge"
        ]
      }

    ]
  }

];