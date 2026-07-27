import '../models/prompt.dart';
import '../models/prompt_section_type.dart';

class PromptRenderer {
  const PromptRenderer();

  String render(Prompt prompt) {
    final buffer = StringBuffer();

    for (final section in prompt.sections) {
      buffer.writeln('# ${_title(section.type)}');
      buffer.writeln();
      buffer.writeln(section.content);
      buffer.writeln();
      buffer.writeln('--------------------------------------------------');
      buffer.writeln();
    }

    return buffer.toString();
  }

  String _title(PromptSectionType type) {
    switch (type) {
      case PromptSectionType.role:
        return 'ROLE';

      case PromptSectionType.input:
        return 'INPUT';

      case PromptSectionType.task:
        return 'TASK';

      case PromptSectionType.principles:
        return 'PRINCIPLES';

      case PromptSectionType.output:
        return 'OUTPUT';
    }
  }
}