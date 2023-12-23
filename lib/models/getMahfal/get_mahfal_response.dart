class GetMahfalResponse {
  List<Data>? data;

  GetMahfalResponse({this.data});

  GetMahfalResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? surah;
  String? link;
  List<String>? surahTags;
  String? place;
  String? timeYear;
  int? sheikhId;

  Data(
      {this.id,
        this.surah,
        this.link,
        this.surahTags,
        this.place,
        this.timeYear,
        this.sheikhId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    surah = json['surah'];
    link = json['link'];
    surahTags = (json['surah_tags'] as List).map((tag) => tag as String).toList();
    place = json['place'];
    timeYear = json['time_year'];
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
