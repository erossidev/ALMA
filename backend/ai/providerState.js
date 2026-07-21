const providerConfig = require("./config/providers");

const providers = {};

for (const provider of providerConfig) {

  providers[provider.id] = {
    failures: 0,
    disabledUntil: 0,
  };

}

const MAX_FAILURES = Number(process.env.AI_MAX_FAILURES || 3);
const DISABLE_TIME = Number(process.env.AI_DISABLE_TIME || 300000);

function isAvailable(name) {

  const provider = providers[name];

  if (!provider) {
    console.warn(`Provider "${name}" non registrato.`);
    return false;
  }

  if (
    provider.disabledUntil > 0 &&
    Date.now() >= provider.disabledUntil
  ) {

    provider.disabledUntil = 0;
    provider.failures = 0;

    console.log(`✅ ${name} nuovamente disponibile`);
  }

  return provider.disabledUntil === 0;

}

function success(name) {

  const provider = providers[name];

  if (!provider) return;

  provider.failures = 0;

}

function failure(name) {

  const provider = providers[name];

  if (!provider) return;

  provider.failures++;

  console.log(
    `⚠️ ${name} errore ${provider.failures}/${MAX_FAILURES}`
  );

  if (provider.failures >= MAX_FAILURES) {

    provider.disabledUntil = Date.now() + DISABLE_TIME;
    provider.failures = 0;

    console.log(`⛔ ${name} disabilitato per 5 minuti`);

  }

}

 module.exports = {
  isAvailable,
  success,
  failure,
};