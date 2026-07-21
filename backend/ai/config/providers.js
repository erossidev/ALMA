const gemini = require("../providers/gemini");
const groq = require("../providers/groq");
const openrouter = require("../providers/openrouter");

module.exports = [
    {
    id: "gemini",
    name: "Gemini",
    priority: 1,
    enabled: true,
    handler: gemini,
    },
    {
    id: "openrouter",
    priority: 2,
    enabled: true,
    handler: openrouter,
    },
    {
    id: "groq",
    name: "Groq",
    priority: 3,
    enabled: true,
    handler: groq,
    },
]; 