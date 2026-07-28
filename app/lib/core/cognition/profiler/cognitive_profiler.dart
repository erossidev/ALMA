class CognitiveProfiler {
  final Stopwatch _total = Stopwatch();

  final Map<String, Stopwatch> _watches = {};

  final Map<String, int> _times = {};

  void start() {
    _total
      ..reset()
      ..start();

    _times.clear();
    _watches.clear();
  }

  void begin(String name) {
    final watch = Stopwatch()..start();
    _watches[name] = watch;
  }

  void end(String name) {
    final watch = _watches[name];

    if (watch == null) {
      return;
    }

    watch.stop();

    _times[name] = watch.elapsedMilliseconds;
  }

  void printReport() {
    _total.stop();

    print("");
    print("======================================");
    print("        COGNITIVE TIMELINE");
    print("======================================");

    for (final entry in _times.entries) {
      print(
        "${entry.key.padRight(20)} ${entry.value} ms",
      );
    }

    print("--------------------------------------");
    print(
      "TOTAL".padRight(20) +
          "${_total.elapsedMilliseconds} ms",
    );
    print("======================================");
    print("");
  }
}