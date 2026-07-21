const axios = require("axios");

module.exports = async function (request) {

    const response = await axios.post(

        "https://openrouter.ai/api/v1/chat/completions",

        {
            model: "openrouter/auto",

            messages: [
                {
                    role: "system",
                    content: request.system
                },
                {
                    role: "user",
                    content: request.user
                }
            ]
        },

        {
            headers: {
                Authorization: `Bearer ${process.env.OPENROUTER_API_KEY}`,
                "Content-Type": "application/json"
            }
        }

    );

    return {

        provider: "OpenRouter",

        model: response.data.model,

        reply: response.data.choices[0].message.content

    };

};