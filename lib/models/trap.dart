// To parse this JSON data, do
//
//     final trap = trapFromJson(jsonString);

import 'dart:convert';

Trap trapFromJson(String str) => Trap.fromJson(json.decode(str));

String trapToJson(Trap data) => json.encode(data.toJson());

class Trap {
  int? id;
  String? resellerId;
  String? hotelId;
  int? duration;
  int? quantity;
  double pricePerOne;
  double rasToUsd;
  double iqdToUsd;
  String? transport;
  DateTime? createdAt;

  Trap({
    this.id,
    this.resellerId,
    this.hotelId,
    this.duration,
    this.quantity,
  required  this.pricePerOne,
  required  this.rasToUsd,
   required this.iqdToUsd,
    this.transport,
    this.createdAt,
  });

  factory Trap.fromJson(Map<String, dynamic> json) => Trap(
    id: json["id"],
    resellerId: json["reseller_id"],
    hotelId: json["hotel_id"],
    duration: json["duration"],
    quantity: json["quantity"],
    pricePerOne: json["price_per_one"],
    rasToUsd: json["RAS_to_USD"],
    iqdToUsd: json["IQD_to_USD"],
    transport: json["transport"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "reseller_id": resellerId,
    "hotel_id": hotelId,
    "duration": duration,
    "quantity": quantity,
    "price_per_one": pricePerOne,
    "RAS_to_USD": rasToUsd,
    "IQD_to_USD": iqdToUsd,
    "transport": transport,
    "created_at": createdAt?.toIso8601String(),
  };
}
