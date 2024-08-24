// To parse this JSON data, do
//
//     final safe = safeFromJson(jsonString);

import 'dart:convert';

Safe safeFromJson(String str) => Safe.fromJson(json.decode(str));

String safeToJson(Safe data) => json.encode(data.toJson());

class Safe {
  int? id;
  String? type;
  String? numberKade;
  String? owner;
  var costUSD;
  String? note;
  var costIQD;
  DateTime? createdAt;
  DateTime? updatedAt;

  Safe({
    this.id,
    this.type,
    this.numberKade,
    this.owner,
    this.costUSD,
    this.note,
    this.costIQD,
    this.createdAt,
    this.updatedAt,
  });

  factory Safe.fromJson(Map<String, dynamic> json) => Safe(
        id: json["id"],
        type: json["type"],
        numberKade: json["number_kade"],
        owner: json["owner"],
        costUSD: json["cost_USD"] == null
            ? null
            : double.parse(json["cost_USD"].toString()),
        note: json["note"],
        costIQD: json["cost_IQD"] == null
            ? null
            : double.parse(json["cost_IQD"].toString()),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "number_kade": numberKade,
        "owner": owner,
        "cost": costUSD,
        "note": note,
        "IQD_to_USD": costIQD,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
