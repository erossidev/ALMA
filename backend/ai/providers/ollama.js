const axios = require("axios");

module.exports = async function (request) {

  try {

    const start = Date.now();

    const response = await axios.post(

      "http://127.0.0.1:11434/api/chat",

      {

        model: request.model || "qwen2.5:3b",

        messages: [

          {
            role: "system",
            content: request.system ?? "",
          },

          {
            role: "user",
            content: request.user,
          },

        ],

        think: false,

        stream: false,

      },

      {

        timeout: request.timeout ?? 180000,

      }

    );

    const responseTimeMs = Date.now() - start;

    if (

      !response.data ||

      !response.data.message ||

      !response.data.message.content

    ) {

      throw new Error(
        "Ollama non ha restituito alcuna risposta."
      );

    }

    return {

      success: true,

      provider: "Ollama",

      model:
        response.data.model ??
        request.model,

      reply:
        response.data.message.content,

      usage: {

        promptTokens:
          response.data.prompt_eval_count ?? 0,

        completionTokens:
          response.data.eval_count ?? 0,

        totalTokens:
          (response.data.prompt_eval_count ?? 0) +
          (response.data.eval_count ?? 0),

        responseTimeMs,

        finishReason: "stop",

      },

    };

  }

  catch (err) {

    if (err.response) {

      throw new Error(
        JSON.stringify({

          provider: "ollama",

          model: request.model,

          status: err.response.status,

          data: err.response.data,

        })
      );

    }

    throw err;

  }

};