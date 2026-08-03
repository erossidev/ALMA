require("dotenv").config();

const Groq = require("groq-sdk");

const groq = new Groq({
  apiKey: process.env.GROQ_API_KEY,
});

module.exports = async function (request) {

  const start = Date.now();

  const completion = await groq.chat.completions.create({
    model: request.model,
    messages: [
      {
        role: "system",
        content: request.system,
      },
      {
        role: "user",
        content: request.user,
      },
    ],
  });

  const responseTimeMs = Date.now() - start;

  return {
    provider: "Groq",

    model: request.model,

    reply: completion.choices[0].message.content,

    usage: {
      promptTokens: completion.usage?.prompt_tokens ?? 0,
      completionTokens: completion.usage?.completion_tokens ?? 0,
      totalTokens: completion.usage?.total_tokens ?? 0,
      responseTimeMs: responseTimeMs,
      finishReason: completion.choices[0].finish_reason ?? "unknown",
    },
  };
};