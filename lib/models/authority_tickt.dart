// To parse this JSON data, do
//
//     final authorityTickt = authorityTicktFromJson(jsonString);

// import 'dart:convert';

import 'package:admin/models/format_price.dart';

// AuthorityTicket authorityTicktFromJson(String str) =>
//     AuthorityTicket.fromJson(json.decode(str));

// String authorityTicktToJson(AuthorityTickt data) => json.encode(data.toJson());

class AuthorityTicket {
  int? id;
  int? authorityId;
  int? numberOfTravel;
  String? priceOfTravel;
  int? commission;
  String? totalPrice;
  String? name;
  int? number_of_child;
  String? price_of_child;
  DateTime? createdAt;
  String? number_kade;
  String? type;
  bool? istyped;

  AuthorityTicket({
    this.id,
    this.authorityId,
    this.numberOfTravel,
    this.priceOfTravel,
    this.commission,
    this.totalPrice,
    this.name,
    this.number_of_child,
    this.price_of_child,
    this.createdAt,
    this.number_kade,
    this.type,
    this.istyped,
  });

  factory AuthorityTicket.fromJson(Map<String, dynamic> json) =>
      AuthorityTicket(
          id: json["id"],
          authorityId: json["authority_id"] ?? 0,
          numberOfTravel: json["number_of_travel"] ?? 0,
          priceOfTravel: formatPrice(json["price_of_travel"] ?? 0),
          commission: json["commission"] ?? 0,
          totalPrice: formatPrice(json["total_price"] ?? 0),
          name: json["name"] ?? "",
          number_of_child: json["number_of_child"] ?? 0,
          price_of_child: formatPrice(json["price_of_child"] ?? 0),
          createdAt: json["created_at"] == null
              ? null
              : DateTime.parse(json["created_at"]),
          number_kade: json["number_kade"] ?? "0",
          type: json["type"] ?? "iqd",
          istyped: json["commission"] == null);

  Map<String, dynamic> toJson() => {
        "id": id,
        "authority_id": authorityId,
        "number_of_travel": numberOfTravel,
        "price_of_travel": priceOfTravel,
        "commission": commission,
        "total_price": totalPrice,
        "created_at": createdAt?.toIso8601String(),
      };
}
