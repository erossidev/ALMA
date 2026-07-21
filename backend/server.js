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

app.post("/chat", async (req, res) => {
  try {
   const { message } = req.body;

   const result = await aiRouter(message);

   res.json(result);
        
  } catch (error) {
    console.error(error);

    res.status(500).json({
      error: error.message,
    });
  }
});

app.listen(process.env.PORT || 3000, () => {
  console.log(`Server avviato sulla porta ${process.env.PORT || 3000}`);
});