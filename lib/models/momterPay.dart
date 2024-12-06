// To parse this JSON data, do
//
//     final momterPay = momterPayFromJson(jsonString);

import 'dart:convert';

MomterPay momterPayFromJson(String str) => MomterPay.fromJson(json.decode(str));

String momterPayToJson(MomterPay data) => json.encode(data.toJson());

class MomterPay {
  final int? id;
  final int? drictId;
  final int? cost;
  final dynamic deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  MomterPay({
    this.id,
    this.drictId,
    this.cost,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory MomterPay.fromJson(Map<String, dynamic> json) => MomterPay(
        id: json["id"],
        drictId: json["drict_id"],
        cost: json["cost"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "drict_id": drictId,
        "cost": cost,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
