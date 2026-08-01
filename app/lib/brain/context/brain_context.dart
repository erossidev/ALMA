import '../brain.dart';
import '../repositories/brain_repository.dart';

class BrainContext {
  final Brain brain;
  final BrainRepository repository;

  const BrainContext({
    required this.brain,
    required this.repository,
  });
}