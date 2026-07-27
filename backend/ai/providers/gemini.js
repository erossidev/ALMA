require("dotenv").config();

const { GoogleGenAI } = require("@google/genai");

const ai = new GoogleGenAI({
  apiKey: process.env.GEMINI_API_KEY,
});

module.exports = async function (request) {
  try {
    const response = await ai.models.generateContent({
      model: request.model,

      config: {
        systemInstruction: request.system,
      },

      contents: request.user,
    });

    return {
      provider: "Gemini",
      model: "gemini-2.5-flash",
      reply: response.text,
    };

  } catch (err) {
    console.dir(err, { depth: null });
    throw err;
  }
};