import 'extracted_entity.dart';

class EntityExtractionResult {

  final List<ExtractedEntity> entities;

  const EntityExtractionResult({
    required this.entities,
  });

  bool get isEmpty =>
      entities.isEmpty;

  bool get isNotEmpty =>
      entities.isNotEmpty;

  ExtractedEntity? get best =>
      isEmpty ? null : entities.first;

}