const AISelector = require("./AISelector");
const ProviderManager = require("./ProviderManager");

const selector = new AISelector();
const manager = new ProviderManager();

module.exports = async function (message) {

  const decision = selector.select(message);

  return await manager.handle(message, decision);

};