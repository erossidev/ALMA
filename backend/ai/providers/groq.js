require("dotenv").config();

const Groq = require("groq-sdk");

const groq = new Groq({
  apiKey: process.env.GROQ_API_KEY,
});

module.exports = async function (request) {
  const completion = await groq.chat.completions.create({
    model: "llama-3.3-70b-versatile",
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

  return {
    provider: "Groq",
    model: "llama-3.3-70b-versatile",
    reply: completion.choices[0].message.content,
  };
};