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
    int? rasToUsd;
    int? iqdToUsd;
    DateTime? createdAt;

    TrapPay({
        this.id,
        this.resellerId,
        this.payNumber,
        this.rasToUsd,
        this.iqdToUsd,
        this.createdAt,
    });

    factory TrapPay.fromJson(Map<String, dynamic> json) => TrapPay(
        id: json["id"],
        resellerId: json["reseller_id"],
        payNumber: json["pay_number"],
        rasToUsd: json["RAS_to_USD"],
        iqdToUsd: json["IQD_to_USD"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "reseller_id": resellerId,
        "pay_number": payNumber,
        "RAS_to_USD": rasToUsd,
        "IQD_to_USD": iqdToUsd,
        "created_at": createdAt?.toIso8601String(),
    };
}
