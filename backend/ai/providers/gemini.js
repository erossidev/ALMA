require("dotenv").config();

const { GoogleGenAI } = require("@google/genai");

const ai = new GoogleGenAI({
  apiKey: process.env.GEMINI_API_KEY,
});

module.exports = async function (request) {
  try {
    const start = Date.now();

    const response = await ai.models.generateContent({
      model: request.model,

      config: {
        systemInstruction: request.system,
      },

      contents: request.user,
    });

    const responseTimeMs = Date.now() - start;

    return {
      success: true,

      provider: "Gemini",

      model: request.model,

      reply: response.text,

      usage: {
        promptTokens:
          response.usageMetadata?.promptTokenCount ?? 0,

        completionTokens:
          response.usageMetadata?.candidatesTokenCount ?? 0,

        totalTokens:
          response.usageMetadata?.totalTokenCount ?? 0,

        responseTimeMs,

        finishReason:
          response.candidates?.[0]?.finishReason ?? "unknown",
      },
    };

  } catch (err) {
    console.dir(err, { depth: null });
    throw err;
  }
};