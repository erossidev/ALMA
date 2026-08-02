import 'entity_extraction_result.dart';

abstract class EntityExtractor {

  const EntityExtractor();

  Future<EntityExtractionResult> extract(
    String text,
  );

}