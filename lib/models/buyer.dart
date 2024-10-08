// To parse this JSON data, do
//
//     final buyer = buyerFromJson(jsonString);

import 'dart:convert';

import 'package:admin/models/format_price.dart';

Buyer buyerFromJson(String str) => Buyer.fromJson(json.decode(str));

String buyerToJson(Buyer data) => json.encode(data.toJson());

class Buyer {
  int? id;
  String? buyer;
  int? buyer_id;
  String? costUsd;
  String? costRas;
  String? note;

  Buyer({
    this.id,
    this.buyer,
    this.buyer_id,
    this.costUsd,
    this.costRas,
    this.note,
  });

  factory Buyer.fromJson(Map<String, dynamic> json) => Buyer(
        id: json["id"],
        buyer: json["buyer"],
        buyer_id: json["buyer_id"],
        costUsd: formatPrice(json["costUSD"]),
        costRas: formatPrice(json["costRAS"]),
        note: json["note"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "buyer": buyer,
        "costUSD": costUsd,
        "costRAS": costRas,
        "note": note,
      };
}
