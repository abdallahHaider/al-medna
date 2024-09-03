import 'package:admin/models/trap.dart';

class ResellerDbet {
  int? countTrap;
  int? countPays;
  String? totalCostUsd;
  double? totalCostIqd;
  double? totalCostRas;
  String? totalCostUsdPays;
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
        totalCostUsd: formatPrice(json["total_cost_USD"]),
        // totalCostIqd: double.parse(json["total_cost_IQD"].toString()),
        // totalCostRas: json["total_cost_RAS"],
        totalCostUsdPays: formatPrice(json["total_cost_USD_pays"]),
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
