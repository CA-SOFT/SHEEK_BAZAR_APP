// ignore_for_file: camel_case_types

class UseAppModel {
  bool? status;
  String? message;
  List<tutorialVideo>? data;

  UseAppModel({this.status, this.message, this.data});

  UseAppModel.fromJson(Map<String, dynamic>? json) {
    status = json?['status'];
    message = json?['message'];
    if (json?['data'] != null) {
      data = <tutorialVideo>[];
      json?['data'].forEach((v) {
        data!.add(tutorialVideo.fromJson(v));
      });
    }
  }

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class tutorialVideo {
  String? id;
  String? link;
  String? description;
  String? sequence;
  String? isVisible;

  tutorialVideo(
      {this.id, this.link, this.description, this.sequence, this.isVisible});

  tutorialVideo.fromJson(Map<String, dynamic>? json) {
    id = json?['id'];
    link = json?['link'];
    description = json?['description'];
    sequence = json?['sequence'];
    isVisible = json?['is_visible'];
  }

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['link'] = link;
    data['description'] = description;
    data['sequence'] = sequence;
    data['is_visible'] = isVisible;
    return data;
  }
}
