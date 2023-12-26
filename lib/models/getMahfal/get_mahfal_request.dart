// ignore_for_file: unnecessary_new

class GetMahfalRequest {
  String? places;
  String? surahName;
  String? times;

  GetMahfalRequest({this.places, this.surahName, this.times});

  GetMahfalRequest.fromJson(Map<String, dynamic> json) {
    places = json['places'];
    surahName = json['surah_name'];
    times = json['times'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['places'] = places;
    data['surah_name'] = surahName;
    data['times'] = times;
    return data;
  }
}
