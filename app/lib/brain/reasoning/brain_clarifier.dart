import '../conflict/brain_conflict.dart';

class BrainClarifier {
  const BrainClarifier();

  Future<String> generate(
    BrainConflict conflict,
  ) async {
    return
        "Prima mi avevi detto una cosa diversa. "
        "Quale informazione è corretta?";
  }
}