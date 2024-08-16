// To parse this JSON data, do
//
//     final trapPay = trapPayFromJson(jsonString);

import 'dart:convert';

TrapPay trapPayFromJson(String str) => TrapPay.fromJson(json.decode(str));

String trapPayToJson(TrapPay data) => json.encode(data.toJson());

class TrapPay {
  int? id;
  String? resellerId;
  String? payNumber;
  double? cost;
  double? rasToUsd;
  double? iqdToUsd;
  double? nowdebt;
  DateTime? createdAt;

  TrapPay({
    this.id,
    this.resellerId,
    this.payNumber,
    this.cost,
    this.rasToUsd,
    this.iqdToUsd,
    this.nowdebt,
    this.createdAt,
  });

  factory TrapPay.fromJson(Map<String, dynamic> json) => TrapPay(
        id: json["id"],
        resellerId: json["reseller_id"],
        payNumber: json["pay_number"],
        cost: double.parse(json["cost"].toString()),
        rasToUsd: double.tryParse(json["RAS_to_USD"].toString()),
        iqdToUsd: double.parse(json["IQD_to_USD"].toString()),
        nowdebt: double.parse(json["now_debt"].toString()),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "reseller_id": resellerId,
        "pay_number": payNumber,
        "cost": cost,
        "RAS_to_USD": rasToUsd,
        "IQD_to_USD": iqdToUsd,
        "created_at": createdAt?.toIso8601String(),
      };
}
