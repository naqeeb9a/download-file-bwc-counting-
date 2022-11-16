// To parse this JSON data, do
//
//     final detailsModel = detailsModelFromJson(jsonString);

import 'dart:convert';

DetailsModel detailsModelFromJson(String str) =>
    DetailsModel.fromJson(json.decode(str));

String detailsModelToJson(DetailsModel data) => json.encode(data.toJson());

class DetailsModel {
  DetailsModel({
    required this.meta,
    required this.data,
  });

  final Meta? meta;
  final Data? data;

  factory DetailsModel.fromJson(Map<String, dynamic> json) => DetailsModel(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "meta": meta == null ? null : meta!.toJson(),
        "data": data == null ? null : data!.toJson(),
      };
}

class Data {
  Data({
    required this.verification,
  });

  final Verification? verification;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        verification: json["verification"] == null
            ? null
            : Verification.fromJson(json["verification"]),
      );

  Map<String, dynamic> toJson() => {
        "verification": verification == null ? null : verification!.toJson(),
      };
}

class Verification {
  Verification({
    required this.message,
    required this.regNumber,
    required this.securityCode,
    required this.serialNo,
    required this.plotSize,
    required this.memberName,
    required this.societyName,
    required this.memberCnic,
    required this.formNo,
    required this.memberId,
    required this.id,
    required this.scanLogId,
    required this.phone,
  });

  final String? message;
  final String? regNumber;
  final String? securityCode;
  final int? serialNo;
  final String? plotSize;
  final String? memberName;
  final String? societyName;
  final String? memberCnic;
  final String? formNo;
  final int? memberId;
  final int? id;
  final int? scanLogId;
  final String? phone;

  factory Verification.fromJson(Map<String, dynamic> json) => Verification(
        message: json["message"],
        regNumber: json["reg_number"],
        securityCode: json["security_code"],
        serialNo: json["serial_no"],
        plotSize: json["plot_size"],
        memberName: json["member_name"],
        societyName: json["society_name"],
        memberCnic: json["member_cnic"],
        formNo: json["form_no"],
        memberId: json["member_id"],
        id: json["id"],
        scanLogId: json["scan_log_id"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "reg_number": regNumber,
        "security_code": securityCode,
        "serial_no": serialNo,
        "plot_size": plotSize,
        "member_name": memberName,
        "society_name": societyName,
        "member_cnic": memberCnic,
        "form_no": formNo,
        "member_id": memberId,
        "id": id,
        "scan_log_id": scanLogId,
        "phone": phone,
      };
}

class Meta {
  Meta({
    required this.status,
    required this.code,
  });

  final bool? status;
  final int? code;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        status: json["status"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
      };
}
