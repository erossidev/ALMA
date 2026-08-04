final prompt = const SemanticParsingPrompt().build(
  const SemanticParsingRequest(
    message: "Mia figlia si chiama Leila.",
  ),
);

final response = await aiManager.extractMeaning(prompt);

print(response);