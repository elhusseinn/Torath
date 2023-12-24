import 'mahfal_data.dart';

class GetMahfalResponse {
  List<MahfalData>? data;

  GetMahfalResponse({this.data});

  GetMahfalResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <MahfalData>[];
      json['data'].forEach((v) {
        data!.add(MahfalData.fromJson(v));
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


