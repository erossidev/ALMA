require("dotenv").config();

const express = require("express");
const cors = require("cors");

const aiRouter = require("./ai/router");
const providers = require("./ai/config/providers");

const routingRepository =
    require("./ai/routing/routingRepository");


const app = express();


app.use(cors());
app.use(express.json());


// ==============================
// HOME
// ==============================

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
// AI PROVIDERS
// ==============================

app.get("/providers", (req, res) => {


  const result = providers.map(provider => ({


    id: provider.id,


    name: provider.name,


    enabled: provider.enabled,


  }));


  res.json(result);


});




// ==============================
// ROUTING
// ==============================

app.get("/routing", (req, res) => {


  res.json(

    routingRepository.getRouting()

  );


});



app.put("/routing", (req, res) => {


  routingRepository.saveRouting(

    req.body

  );


  res.json({

    success: true,

  });


});




// ==============================
// START SERVER
// ==============================

app.listen(
  process.env.PORT || 3000,
  () => {

    console.log(

      `Server avviato sulla porta ${process.env.PORT || 3000}`

    );

  }
);