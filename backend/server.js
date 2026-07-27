require("dotenv").config();

const express = require("express");
const cors = require("cors");
const aiRouter = require("./ai/router");

const app = express();

app.use(cors());
app.use(express.json());

app.get("/", (req, res) => {
  res.send("ALMA Backend Online");
});

// ==============================
// CHAT
// ==============================

app.post("/chat", async (req, res) => {
  try {
      const {
      message,
      provider,
      model,
    } = req.body;

    const result = await aiRouter({
      message,
      provider,
      model,
    });

    res.json(result);

  } catch (error) {
    console.error(error);

    res.status(500).json({
      error: error.message,
    });
  }
});

// ==============================
// AI RESOURCES
// ==============================

app.get("/resources", (req, res) => {

  res.json([
    {
      id: "default",

      providerId: "openrouter",

      modelId: "openai/gpt-5",

      displayName: "GPT-5",

      enabled: true,

      priority: 1,

      capabilities: [
        "conversation",
        "reasoning",
        "json",
        "coding"
      ]
    }
  ]);

});

// ==============================

app.listen(process.env.PORT || 3000, () => {
  console.log(
    `Server avviato sulla porta ${process.env.PORT || 3000}`,
  );
});