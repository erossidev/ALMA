require("dotenv").config();
console.log(process.env.GEMINI_API_KEY?.substring(0, 10));

const { GoogleGenAI } = require("@google/genai");

const ai = new GoogleGenAI({
  apiKey: process.env.GEMINI_API_KEY,
});

async function main() {
  try {
    console.log("Prima della chiamata...");

    const response = await ai.models.generateContent({
    model: "gemini-2.0-flash-001",
    contents: "Rispondi solo con OK",
    });

    console.log("Dopo la chiamata");
    console.log(response);
    console.log("TESTO:", response.text);

  } catch (err) {
    console.error("ERRORE:");
    console.error(err);
  }
}

main();