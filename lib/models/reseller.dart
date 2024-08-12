// To parse this JSON data, do
//
//     final reseller = resellerFromJson(jsonString);

import 'dart:convert';

Reseller resellerFromJson(String str) => Reseller.fromJson(json.decode(str));

String resellerToJson(Reseller data) => json.encode(data.toJson());

class Reseller {
    int? id;
    String? fullName;
    String? phoneNumber;
    String? address;
    DateTime? createdAt;
    DateTime? updatedAt;

    Reseller({
        this.id,
        this.fullName,
        this.phoneNumber,
        this.address,
        this.createdAt,
        this.updatedAt,
    });

    factory Reseller.fromJson(Map<String, dynamic> json) => Reseller(
        id: json["id"],
        fullName: json["full_name"],
        phoneNumber: json["phone_number"],
        address: json["address"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "phone_number": phoneNumber,
        "address": address,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
