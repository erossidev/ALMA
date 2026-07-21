const providers = require("./config/providers");

class AISelector {

  select(message) {

    const provider = providers
      .filter(p => p.enabled)
      .sort((a, b) => a.priority - b.priority)[0];

    return {
      preferredProvider: provider.id
    };

  }

}

module.exports = AISelector;