// To parse this JSON data, do
//
//     final momter = momterFromJson(jsonString);

import 'dart:convert';

import 'package:admin/models/format_price.dart';

Momter momterFromJson(String str) => Momter.fromJson(json.decode(str));

String momterToJson(Momter data) => json.encode(data.toJson());

class Momter {
  final int? id;
  final dynamic nameOfTrap;
  final String? fullName;
  final String? phoneNumber;
  final String? address;
  final String? totalCost;
  final String? rest;
  final String? paid;
  final Trap? trap;
  final String? date;

  Momter({
    this.id,
    this.nameOfTrap,
    this.fullName,
    this.phoneNumber,
    this.address,
    this.totalCost,
    this.rest,
    this.paid,
    this.trap,
    this.date,
  });

  factory Momter.fromJson(Map<String, dynamic> json) => Momter(
        id: json["id"],
        nameOfTrap: json["name_of_trap"],
        fullName: json["full_name"],
        phoneNumber: json["phone_number"],
        address: json["address"],
        totalCost: formatPrice(json["total_cost"]),
        rest: formatPrice(json["rest"]),
        paid: formatPrice(json["paid"]),
        date: json["date"],
        trap: json["trap"] == null ? null : Trap.fromJson(json["trap"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name_of_trap": nameOfTrap,
        "full_name": fullName,
        "phone_number": phoneNumber,
        "address": address,
        "total_cost": totalCost,
        "rest": rest,
        "paid": paid,
        "trap": trap?.toJson(),
      };
}

class Trap {
  final int? id;
  final String? nameOfTripe;
  final int? momtamerId;
  final DateTime? dateOfTrip;
  final String? cost;
  final dynamic numberOfPushes;
  final dynamic dayInMonth;
  final DateTime? dateOfStart;
  final dynamic deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Trap({
    this.id,
    this.nameOfTripe,
    this.momtamerId,
    this.dateOfTrip,
    this.cost,
    this.numberOfPushes,
    this.dayInMonth,
    this.dateOfStart,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Trap.fromJson(Map<String, dynamic> json) => Trap(
        id: json["id"],
        nameOfTripe: json["name_of_tripe"],
        momtamerId: json["momtamer_id"],
        dateOfTrip: json["date_of_trip"] == null
            ? null
            : DateTime.parse(json["date_of_trip"]),
        cost: formatPrice(json["cost"]),
        numberOfPushes: json["number_of_pushes"] ?? 0,
        dayInMonth: json["day_in_month"] ?? 0,
        dateOfStart: json["date_of_start"] == null
            ? null
            : DateTime.parse(json["date_of_start"]),
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name_of_tripe": nameOfTripe,
        "momtamer_id": momtamerId,
        "date_of_trip":
            "${dateOfTrip!.year.toString().padLeft(4, '0')}-${dateOfTrip!.month.toString().padLeft(2, '0')}-${dateOfTrip!.day.toString().padLeft(2, '0')}",
        "cost": cost,
        "number_of_pushes": numberOfPushes,
        "day_in_month": dayInMonth,
        "date_of_start":
            "${dateOfStart!.year.toString().padLeft(4, '0')}-${dateOfStart!.month.toString().padLeft(2, '0')}-${dateOfStart!.day.toString().padLeft(2, '0')}",
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
