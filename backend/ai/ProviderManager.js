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

class ProviderManager {

      buildRequest(
      message,
      preferredModel,
    ) {
      return {
        system: require("./prompts/systemPrompt"),
        user: message,
        model: preferredModel,
      };
    }

getActiveProviders(preferredProvider = null) {

  const active = providers.filter(p => p.enabled);

  if (!preferredProvider) {
    return active.sort((a, b) => a.priority - b.priority);
  }

  return active.sort((a, b) => {

    if (a.id === preferredProvider) return -1;
    if (b.id === preferredProvider) return 1;

    return a.priority - b.priority;

  });

}

  async executeProvider(provider, request) {
    try {
      console.log(`🧠 Provo ${provider.name}...`);

      const response = await withTimeout(
        provider.handler(request),
        TIMEOUT
      );

      state.success(provider.id);

      return response;

    } catch (err) {

      console.log(`❌ ${provider.name}:`, err.message);

      state.failure(provider.id);

      return null;
    }
  }

  async handle(message, options = {}) {

    const {
          preferredProvider,
          preferredModel,
        } = options;

        const request = this.buildRequest(
          message,
          preferredModel,
        );;
        
   const providers = this.getActiveProviders(preferredProvider);
   
    for (const provider of providers) {

      if (!state.isAvailable(provider.id)) {
        console.log(`⛔ ${provider.name} temporaneamente disabilitato`);
        continue;
      }

      const response = await this.executeProvider(provider, request);

      if (response) {
        return response;
      }
    }

    throw new Error("Nessun provider AI disponibile");
  }

}

module.exports = ProviderManager;