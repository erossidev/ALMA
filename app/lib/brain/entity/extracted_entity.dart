import 'entity_source.dart';

class ExtractedEntity {

  final String text;

  final String? type;

  final double confidence;

  final EntitySource source;

  final int start;

  final int end;

  const ExtractedEntity({
    required this.text,
    this.type,
    required this.confidence,
    required this.source,
    required this.start,
    required this.end,
  });

}