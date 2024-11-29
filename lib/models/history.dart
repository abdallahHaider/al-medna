class History {
  int? id;
  String? type;
  int? modelId;
  String? modeName;
  String? title;
  String? description;
  Map<String, dynamic>? details;
  List<dynamic>? nameOfRows;
  DateTime? createdAt;
  DateTime? updatedAt;

  History({
    this.id,
    this.type,
    this.modelId,
    this.modeName,
    this.title,
    this.description,
    this.details,
    this.nameOfRows,
    this.createdAt,
    this.updatedAt,
  });

  factory History.fromJson(Map<String, dynamic> json) => History(
        id: json["id"],
        type: json["type"],
        modelId: json["model_id"],
        modeName: json["mode_name"],
        title: json["title"],
        description: json["description"],
        details: json["details"] == null ? null : json["details"],
        nameOfRows: json["name_of_rows"] == null
            ? []
            : List<dynamic>.from(json["name_of_rows"]!.map((x) => x)),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "model_id": modelId,
        "mode_name": modeName,
        "title": title,
        "description": description,
        // "details": details?.toJson(),
        "name_of_rows": nameOfRows == null
            ? []
            : List<dynamic>.from(nameOfRows!.map((x) => x)),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

// class Details {
//   String? ll;

//   Details({
//     this.ll,
//   });

//   factory Details.fromJson(Map<String, dynamic> json) => Details(
//         ll: json["ll"],
//       );

//   Map<String, dynamic> toJson() => {
//         "ll": ll,
//       };
// }
