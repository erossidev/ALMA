class RoutingRepository {

  constructor() {

    this.routing = {

      dialogue: "groq_llama70b",

      learning: "groq_qwen27b",

      knowledge: "groq_qwen27b",

      reasoning: "groq_gptoss120b",

      planning: "groq_gptoss120b",

      coding: "openrouter_gpt5",

      vision: "gemini_flash",

      memory: "groq_llama70b",

      language: "groq_llama70b",

      ontology: "groq_qwen27b",
    };
  }

  getRouting() {
    return this.routing;
  }

  saveRouting(routing) {
    this.routing = routing;
  }

}

module.exports = new RoutingRepository();