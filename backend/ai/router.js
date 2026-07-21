const providers = require("./config/providers");

const state = require("./providerState");

const TIMEOUT = Number(process.env.AI_TIMEOUT || 2000);


function withTimeout(promise, ms) {
  return Promise.race([
    promise,
    new Promise((_, reject) =>
      setTimeout(() => reject(new Error("Timeout")), ms)
    ),
  ]);
}

const activeProviders = providers
  .filter(p => p.enabled)
  .sort((a, b) => a.priority - b.priority);

module.exports = async function (message) {
  for (const provider of activeProviders) {
    if (!state.isAvailable(provider.id)) {
      console.log(`⛔ ${provider.name} temporaneamente disabilitato`);
      continue;
    }

    try {
      console.log(`🧠 Provo ${provider.name}...`);

      const request = {
      system: require("./prompts/systemPrompt"),
      user: message,
      };

      const response = await withTimeout(
        provider.handler(request),
        TIMEOUT
      );

      state.success(provider.id);

      return response;

    } catch (err) {
      console.log(`❌ ${provider.name}:`, err.message);

      state.failure(provider.id);
    }
  }

  throw new Error("Nessun provider AI disponibile");
};