const gemini = require("../providers/gemini");
const groq = require("../providers/groq");
const openrouter = require("../providers/openrouter");

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
        id: "openrouter-auto",
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
        id: "gpt5",
        modelId: "openai/gpt-5-mini",
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
        id: "gpt5mini",
        modelId: "openai/gpt-5-mini",
        displayName: "GPT-5 Mini",
        priority: 2,
        capabilities: [
          "conversation",
          "reasoning"
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
        id: "gemini25flash",
        modelId: "gemini-2.5-flash",
        displayName: "Gemini 2.5 Flash",
        priority: 4,
        capabilities: [
          "conversation",
          "reasoning",
          "json"
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
          id: "llama70b",
          modelId: "llama-3.3-70b-versatile",
          displayName: "Llama 70B",
          priority: 5,
          capabilities: [
            "conversation",
            "reasoning",
            "json"
          ]
        }
    ]
  }

];