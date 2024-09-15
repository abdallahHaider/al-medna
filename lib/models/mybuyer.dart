// To parse this JSON data, do
//
//     final myBuyer = myBuyerFromJson(jsonString);

import 'dart:convert';

MyBuyer myBuyerFromJson(String str) => MyBuyer.fromJson(json.decode(str));

String myBuyerToJson(MyBuyer data) => json.encode(data.toJson());

class MyBuyer {
  int? id;
  String? buyer;
  int? costUsd;
  int? costRas;
  String? note;

  MyBuyer({
    this.id,
    this.buyer,
    this.costUsd,
    this.costRas,
    this.note,
  });

  factory MyBuyer.fromJson(Map<String, dynamic> json) => MyBuyer(
        id: json["id"],
        buyer: json["buyer"],
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
