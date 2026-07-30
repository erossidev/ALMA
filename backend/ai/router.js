const ProviderManager = require("./ProviderManager");

const manager = new ProviderManager();

module.exports = async function ({
  message,
  provider,
  model,
  maxTokens,
  temperature,
  timeout,
}) {

  return await manager.handle(
    message,
    {
      preferredProvider: provider,
      preferredModel: model,

      maxTokens,
      temperature,
      timeout,
    },
  );

};