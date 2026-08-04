class MeaningParserException implements Exception {
  final String message;

  const MeaningParserException(this.message);

  @override
  String toString() => message;
}