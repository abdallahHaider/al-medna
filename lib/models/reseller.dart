import 'dart:convert';

import 'package:admin/models/format_price.dart';

Reseller resellerFromJson(String str) => Reseller.fromJson(json.decode(str));

String resellerToJson(Reseller data) => json.encode(data.toJson());

class Reseller {
  int? id;
  String? fullName;
  String? phoneNumber;
  String? address;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? now_debt;
  bool?
      isSold; // تأكد من أن هذه الخاصية موجودة أو استخدم خاصية أخرى تعبر عن حالة البيع
  String? name;

  Reseller({
    this.id,
    this.fullName,
    this.phoneNumber,
    this.address,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.now_debt,
    this.isSold,
  });

  factory Reseller.fromJson(Map<String, dynamic> json) => Reseller(
        id: json["id"],
        fullName: json["full_name"] ?? json["name"] ?? "",
        phoneNumber: json["phone_number"].toString(),
        address: json["address"].toString(),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        now_debt: formatPrice(json["now_debt"] ?? 0),
        isSold:
            json['is_sold'] ?? false, // تأكد من تطابق الاسم مع الخاصية في JSON
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
