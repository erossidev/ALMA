const ProviderManager = require("./ProviderManager");

const manager = new ProviderManager();

module.exports = async function ({
  message,
  provider,
  model,
}) {

  return await manager.handle(
    message,
    {
      preferredProvider: provider,
      preferredModel: model,
    },
  );

};