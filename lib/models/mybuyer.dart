// To parse this JSON data, do
//
//     final myBuyer = myBuyerFromJson(jsonString);

import 'dart:convert';

MyBuyer myBuyerFromJson(String str) => MyBuyer.fromJson(json.decode(str));

String myBuyerToJson(MyBuyer data) => json.encode(data.toJson());

class MyBuyer {
  int? id;
  String? buyer;
  String? hotel_name;
  int? costUsd;
  int? costRas;
  String? note;

  MyBuyer({
    this.id,
    this.buyer,
    this.hotel_name,
    this.costUsd,
    this.costRas,
    this.note,
  });

  factory MyBuyer.fromJson(Map<String, dynamic> json) => MyBuyer(
        id: json["id"],
        buyer: json["buyer"],
        hotel_name: json["hotel_name"],
        costUsd: json["costUSD"],
        costRas: json["costRAS"],
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
