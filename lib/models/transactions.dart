class Transactions {
  Transactions({
    required this.id,
    // required this.fBank,
    // required this.fSmallBank,
    // required this.tBank,
    // required this.tSmallBank,
    required this.costUsd,
    required this.costIqd,
    required this.senderName,
    required this.getterName,
    required this.numberKade,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  // final dynamic fBank;
  // final dynamic fSmallBank;
  // final dynamic tBank;
  // final dynamic tSmallBank;
  final dynamic costUsd;
  final dynamic costIqd;
  final String? senderName;
  final String? getterName;
  final String? numberKade;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Transactions.fromJson(Map<String, dynamic> json) {
    return Transactions(
      id: json["id"],
      // fBank: json["f_bank"],
      // fSmallBank: json["f_small_bank"],
      // tBank: json["t_bank"],
      // tSmallBank: json["t_small_bank"],
      costUsd: json["cost_USD"] ?? "",
      costIqd: json["cost_IQD"] ?? "",
      senderName: json["sender_name"],
      getterName: json["getter_name"],
      numberKade: json["number_kade"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }
}
