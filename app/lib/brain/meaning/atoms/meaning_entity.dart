class MeaningEntity extends MeaningAtom {
  final String id;
  final String text;
  final String kind;

  const MeaningEntity({
    required this.id,
    required this.text,
    required this.kind,
  });
}