require("dotenv").config();

const express = require("express");
const cors = require("cors");

const aiRouter = require("./ai/router");
const providers = require("./ai/config/providers");

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
      maxTokens,
      temperature,
      timeout,
    } = req.body;

    const result = await aiRouter({
      message,
      provider,
      model,
      maxTokens,
      temperature,
      timeout,
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

  const resources = [];

  for (const provider of providers) {

    if (!provider.enabled) {
      continue;
    }

    for (const resource of provider.resources) {

     resources.push({

        id: resource.id,

        providerId: provider.id,

        modelId: resource.modelId,

        displayName: resource.displayName,

        enabled: provider.enabled,

        priority: resource.priority,

        capabilities: resource.capabilities,

      });

    }

  }

  res.json(resources);

});

// ==============================

app.listen(process.env.PORT || 3000, () => {
  console.log(
    `Server avviato sulla porta ${process.env.PORT || 3000}`,
  );
});