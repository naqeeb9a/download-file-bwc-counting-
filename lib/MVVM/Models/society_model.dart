// To parse this JSON data, do
//
//     final societyModel = societyModelFromJson(jsonString);

import 'dart:convert';

SocietyModel societyModelFromJson(String str) =>
    SocietyModel.fromJson(json.decode(str));

String societyModelToJson(SocietyModel data) => json.encode(data.toJson());

class SocietyModel {
  SocietyModel({
    required this.data,
  });

  final Data? data;

  factory SocietyModel.fromJson(Map<String, dynamic> json) => SocietyModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data!.toJson(),
      };
}

class Data {
  Data({
    required this.message,
    required this.societies,
  });

  final String? message;
  final List<Society>? societies;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        message: json["message"],
        societies: json["societies"] == null
            ? null
            : List<Society>.from(
                json["societies"].map((x) => Society.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "societies": societies == null
            ? null
            : List<dynamic>.from(societies!.map((x) => x.toJson())),
      };
}

class Society {
  Society({
    required this.id,
    required this.title,
    required this.shortcode,
  });

  final int? id;
  final String? title;
  final String? shortcode;

  factory Society.fromJson(Map<String, dynamic> json) => Society(
        id: json["id"],
        title: json["title"],
        shortcode: json["shortcode"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "shortcode": shortcode,
      };
}
