// To parse this JSON data, do
//
//     final authorityTickt = authorityTicktFromJson(jsonString);

import 'dart:convert';

AuthorityTickt authorityTicktFromJson(String str) =>
    AuthorityTickt.fromJson(json.decode(str));

String authorityTicktToJson(AuthorityTickt data) => json.encode(data.toJson());

class AuthorityTickt {
  int? id;
  int? authorityId;
  int? numberOfTravel;
  int? priceOfTravel;
  int? commission;
  int? totalPrice;
  String? name;
  int? number_of_child;
  int? price_of_child;
  DateTime? createdAt;

  AuthorityTickt({
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
  });

  factory AuthorityTickt.fromJson(Map<String, dynamic> json) => AuthorityTickt(
        id: json["id"],
        authorityId: json["authority_id"],
        numberOfTravel: json["number_of_travel"],
        priceOfTravel: json["price_of_travel"],
        commission: json["commission"],
        totalPrice: json["total_price"],
        name: json["name"],
        number_of_child: json["number_of_child"],
        price_of_child: json["price_of_child"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

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
