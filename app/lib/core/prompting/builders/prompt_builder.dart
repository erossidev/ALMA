import '../models/prompt.dart';
import '../models/prompt_section.dart';
import '../models/prompt_section_type.dart';

class PromptBuilder {
  final String name;

  final String version;

  final List<PromptSection> _sections = [];

  PromptBuilder({
    required this.name,
    required this.version,
  });

  PromptBuilder role(String content) {
    _sections.add(
      PromptSection(
        type: PromptSectionType.role,
        content: content,
      ),
    );

    return this;
  }

  PromptBuilder input(String content) {
    _sections.add(
      PromptSection(
        type: PromptSectionType.input,
        content: content,
      ),
    );

    return this;
  }

  PromptBuilder task(String content) {
    _sections.add(
      PromptSection(
        type: PromptSectionType.task,
        content: content,
      ),
    );

    return this;
  }

  PromptBuilder principles(String content) {
    _sections.add(
      PromptSection(
        type: PromptSectionType.principles,
        content: content,
      ),
    );

    return this;
  }

  PromptBuilder output(String content) {
    _sections.add(
      PromptSection(
        type: PromptSectionType.output,
        content: content,
      ),
    );

    return this;
  }

  Prompt build() {
    return Prompt(
      name: name,
      version: version,
      sections: List.unmodifiable(_sections),
    );
  }
}