class MineAction {
  final int? id;
  final String? name;

  MineAction({required this.id, required this.name});

  factory MineAction.fromJson(Map<String, dynamic> json) => MineAction(
        id: json["id"],
        name: json["name"],
      );
}
