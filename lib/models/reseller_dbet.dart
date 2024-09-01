// To parse this JSON data, do
//
//     final resellerDbet = resellerDbetFromJson(jsonString);

import 'dart:convert';

ResellerDbet resellerDbetFromJson(String str) =>
    ResellerDbet.fromJson(json.decode(str));

String resellerDbetToJson(ResellerDbet data) => json.encode(data.toJson());

class ResellerDbet {
  int? countTrap;
  int? countPays;
  double? totalCostUsd;
  double? totalCostIqd;
  double? totalCostRas;
  double? totalCostUsdPays;
  double? totalCostIqdPays;
  double? totalCostRasPays;

  ResellerDbet({
    this.countTrap,
    this.countPays,
    this.totalCostUsd,
    this.totalCostIqd,
    this.totalCostRas,
    this.totalCostUsdPays,
    this.totalCostIqdPays,
    this.totalCostRasPays,
  });

  factory ResellerDbet.fromJson(Map<String, dynamic> json) => ResellerDbet(
        countTrap: json["count_trap"],
        countPays: json["count_pays"],
        totalCostUsd: json["total_cost_USD"],
        // totalCostIqd: double.parse(json["total_cost_IQD"].toString()),
        // totalCostRas: json["total_cost_RAS"],
        totalCostUsdPays: json["total_cost_USD_pays"],
        // totalCostIqdPays: json["total_cost_IQD_pays"] as double,
        // totalCostRasPays: json["total_cost_RAS_pays"],
      );

  Map<String, dynamic> toJson() => {
        "count_trap": countTrap,
        "count_pays": countPays,
        "total_cost_USD": totalCostUsd,
        "total_cost_IQD": totalCostIqd,
        "total_cost_RAS": totalCostRas,
        "total_cost_USD_pays": totalCostUsdPays,
        "total_cost_IQD_pays": totalCostIqdPays,
        "total_cost_RAS_pays": totalCostRasPays,
      };
}
