import 'semantic_parsing_request.dart';

class SemanticParsingPrompt {

  const SemanticParsingPrompt();

  String build(
    SemanticParsingRequest request,
  ) {

    return '''

You are a semantic parser.

Return JSON.

INPUT

${request.message}

''';

  }

}