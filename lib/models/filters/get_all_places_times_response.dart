class GetAllPlacesTimesResponse {
  List<Data>? data;
  Set<String> places = <String>{};
  Set<String> times = <String>{};

  GetAllPlacesTimesResponse({this.data});

  GetAllPlacesTimesResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        places.add(Data.fromJson(v).place!);
        times.add(Data.fromJson(v).timeYear!);
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
  String? place;
  String? timeYear;

  Data({this.place, this.timeYear});

  Data.fromJson(Map<String, dynamic> json) {
    place = json['place'];
    timeYear = json['time_year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['place'] = place;
    data['time_year'] = timeYear;
    return data;
  }
}
