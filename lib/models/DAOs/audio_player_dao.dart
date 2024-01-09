class AudioPlayerDao {
  String link;
  String surahName;
  String place;
  String time;
  bool? miniPlayerOpened;

  AudioPlayerDao(
      {required this.link,
      required this.surahName,
      required this.place,
      required this.time,
      this.miniPlayerOpened});
}
