const providers = require("./config/providers");

class ProviderManager {

  buildRequest(message, preferredModel) {
    return {
      system: require("./prompts/systemPrompt"),
      user: message,
      model: preferredModel,
    };
  }

  async handle(message, options = {}) {

    const {
      preferredProvider,
      preferredModel,
    } = options;

    const provider = providers.find(
      p => p.id === preferredProvider && p.enabled,
    );

    if (!provider) {
      throw new Error(
        `Provider '${preferredProvider}' non trovato.`,
      );
    }

    const request = this.buildRequest(
      message,
      preferredModel,
    );

    try {

      console.log(
        `🧠 ${provider.name} (${preferredModel})`,
      );

      return await provider.handler(request);

    } catch (err) {

      console.error(err);

      throw new Error(
        JSON.stringify({
          provider: provider.id,
          model: preferredModel,
          code: err.code || "provider_error",
          message: err.message,
        }),
      );

    }

  }

}

module.exports = ProviderManager;