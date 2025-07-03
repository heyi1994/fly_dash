extension GameString on String {
  String get gamePath =>
      replaceFirst("assets/images/", "").replaceFirst("assets/audio/", "");
}
