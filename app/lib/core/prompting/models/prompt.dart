import 'prompt_section.dart';

class Prompt {
  final String name;

  final String version;

  final List<PromptSection> sections;

  const Prompt({
    required this.name,
    required this.version,
    required this.sections,
  });
}