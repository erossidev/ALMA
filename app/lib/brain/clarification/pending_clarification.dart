import '../conflict/brain_conflict.dart';

class PendingClarification {
  final BrainConflict? conflict;

  final String question;

  final DateTime createdAt;

  const PendingClarification({
    this.conflict,
    required this.question,
    required this.createdAt,
  });
}