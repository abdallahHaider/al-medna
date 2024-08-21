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
  var cost;
  String? note;
  var iqdToUsd;
  DateTime? createdAt;
  DateTime? updatedAt;

  Safe({
    this.id,
    this.type,
    this.numberKade,
    this.owner,
    this.cost,
    this.note,
    this.iqdToUsd,
    this.createdAt,
    this.updatedAt,
  });

  factory Safe.fromJson(Map<String, dynamic> json) => Safe(
        id: json["id"],
        type: json["type"],
        numberKade: json["number_kade"],
        owner: json["owner"],
        cost: json["cost"] as double,
        note: json["note"],
        iqdToUsd: json["IQD_to_USD"] as double,
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
        "cost": cost,
        "note": note,
        "IQD_to_USD": iqdToUsd,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
