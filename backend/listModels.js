require("dotenv").config();

const { GoogleGenAI } = require("@google/genai");

const ai = new GoogleGenAI({
  apiKey: process.env.GEMINI_API_KEY,
});

(async () => {
  for await (const model of ai.models.list()) {
    console.log(model.name);
  }
})();