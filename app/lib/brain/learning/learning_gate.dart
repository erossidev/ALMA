class LearningGate {
  const LearningGate();

  bool shouldLearn(String message) {
    final text = message.trim().toLowerCase();

    // Domande esplicite
    if (text.contains("?")) {
      return false;
    }

    // Parole interrogative
    const questionWords = [
      "come",
      "cosa",
      "chi",
      "quando",
      "dove",
      "quale",
      "quali",
      "quanto",
      "quanti",
      "perché",
      "perche",
    ];

    for (final word in questionWords) {
      if (text.startsWith("$word ")) {
        return false;
      }
    }

    return true;
  }
}