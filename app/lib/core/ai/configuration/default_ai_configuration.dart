import '../ai_task.dart';
import 'ai_configuration.dart';

const defaultAIConfiguration = AIConfiguration(
  routing: {
    AITask.dialogue: "groq_llama70b",
    AITask.language: "groq_llama70b",

    AITask.learning: "groq_qwen27b",
    AITask.knowledge: "groq_gptoss120b",
    AITask.ontologyNormalization: "groq_qwen27b",

    AITask.reasoning: "groq_gptoss120b",
    AITask.planning: "groq_gptoss120b",

    AITask.coding: "openrouter_gpt5",

    AITask.vision: "gemini_flash",

    AITask.emotion: "groq_llama70b",

    AITask.tool: "ollama_qwen3",
  },
);