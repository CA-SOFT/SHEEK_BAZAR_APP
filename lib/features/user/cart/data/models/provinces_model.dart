class ProvincesModel {
  List<Provinces>? provinces;

  ProvincesModel({this.provinces});

  ProvincesModel.fromJson(Map<String, dynamic>? json) {
    if (json?['provinces'] != null) {
      provinces = <Provinces>[];
      json?['provinces'].forEach((v) {
        provinces!.add(Provinces.fromJson(v));
      });
    }
  }

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (provinces != null) {
      data['provinces'] = provinces!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Provinces {
  String? provinceId;
  String? provinceNameAr;
  String? provinceNameEn;
  String? provinceNameKu;

  Provinces(
      {this.provinceId,
      this.provinceNameAr,
      this.provinceNameEn,
      this.provinceNameKu});

  Provinces.fromJson(Map<String, dynamic>? json) {
    provinceId = json?['province_id'];
    provinceNameAr = json?['province_name_ar'];
    provinceNameEn = json?['province_name_en'];
    provinceNameKu = json?['province_name_ku'];
  }

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['province_id'] = provinceId;
    data['province_name_ar'] = provinceNameAr;
    data['province_name_en'] = provinceNameEn;
    data['province_name_ku'] = provinceNameKu;
    return data;
  }
}
