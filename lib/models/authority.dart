// To parse this JSON data, do
//
//     final Authority = AuthorityFromJson(jsonString);

import 'dart:convert';

Authority AuthorityFromJson(String str) => Authority.fromJson(json.decode(str));

String AuthorityToJson(Authority data) => json.encode(data.toJson());

class Authority {
  String? name;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  Authority({
    this.name,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory Authority.fromJson(Map<String, dynamic> json) => Authority(
        name: json["name"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
      };
}
