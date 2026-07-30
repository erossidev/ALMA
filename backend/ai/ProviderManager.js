const providers = require("./config/providers");

class ProviderManager {

  buildRequest(
    message,
    preferredModel,
    options = {},
  ) {

    return {

      system: require("./prompts/systemPrompt"),

      user: message,

      model: preferredModel,

      maxTokens: options.maxTokens,

      temperature: options.temperature,

      timeout: options.timeout,

    };

  }

  async handle(message, options = {}) {

    const {

      preferredProvider,

      preferredModel,

      maxTokens,

      temperature,

      timeout,

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

      {
        maxTokens,
        temperature,
        timeout,
      },

    );

    console.log("");

    console.log("===== PROVIDER =====");

    console.log(provider.name);

    console.log(preferredModel);

    console.log("Temperature:", request.temperature);

    console.log("Max Tokens:", request.maxTokens);

    console.log("Timeout:", request.timeout);

    console.log("====================");

    try {

      const response =
          await provider.handler(request);

      return response;

    } catch (err) {

      console.error("");

      console.error("===== PROVIDER ERROR =====");

      console.error(err);

      console.error("==========================");

      console.error("");

      throw err;

    }

  }

}

module.exports = ProviderManager;