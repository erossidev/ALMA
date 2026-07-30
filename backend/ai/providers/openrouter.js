const axios = require("axios");

module.exports = async function (request) {

    try {

        const response = await axios.post(

            "https://openrouter.ai/api/v1/chat/completions",

            {
                model: request.model || "openrouter/auto",

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

                temperature: request.temperature ?? 0,

                max_tokens: request.maxTokens ?? 600,

            },

            {
                timeout: request.timeout ?? 15000,

                headers: {
                    Authorization: `Bearer ${process.env.OPENROUTER_API_KEY}`,
                    "Content-Type": "application/json",
                },
            }

        );

        if (
            !response.data ||
            !response.data.choices ||
            response.data.choices.length === 0
        ) {

            console.error("");
            console.error("===== OPENROUTER INVALID RESPONSE =====");
            console.error(response.data);
            console.error("=======================================");
            console.error("");

            throw new Error(
                "OpenRouter non ha restituito alcuna risposta."
            );

        }

        return {

            success: true,

            provider: "OpenRouter",

            model:
                response.data.model ??
                request.model,

            reply:
                response.data.choices[0].message.content,

        };

    } catch (err) {

        if (err.response) {

            console.error("");
            console.error("===== OPENROUTER ERROR =====");
            console.error("Status :", err.response.status);
            console.error("Data   :", err.response.data);
            console.error("============================");
            console.error("");

            throw new Error(
                JSON.stringify({

                    provider: "openrouter",

                    model: request.model,

                    status: err.response.status,

                    data: err.response.data,

                })
            );

        }

        console.error("");
        console.error("===== OPENROUTER EXCEPTION =====");
        console.error(err);
        console.error("================================");
        console.error("");

        throw err;

    }

};