class MahfalData {
  int? id;
  String? surah;
  String? link;
  List<String>? surahTags;
  String? place;
  String? timeYear;
  int? sheikhId;

  MahfalData(
      {this.id,
      this.surah,
      this.link,
      this.surahTags,
      this.place,
      this.timeYear,
      this.sheikhId});

  MahfalData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    surah = json['surah'];
    link = json['link'];
    surahTags = json['surah_tags'] != null
        ? (json['surah_tags'] as List).map((tag) => tag as String).toList()
        : [];
    place = json['place'] ?? "غير معروف";
    timeYear = json['time_year'] ?? "غير معروف";
    sheikhId = json['sheikh_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['surah'] = surah;
    data['link'] = link;
    data['surah_tags'] = surahTags;
    data['place'] = place;
    data['time_year'] = timeYear;
    data['sheikh_id'] = sheikhId;
    return data;
  }
}
