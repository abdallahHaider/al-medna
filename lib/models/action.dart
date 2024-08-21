class TypeAction {
  final String name;
  final String id;

  TypeAction({required this.name, required this.id});

  static List<TypeAction> get actions => [
        TypeAction(name: 'سند قبض', id: 'pay'),
        TypeAction(name: 'سند صرف', id: 'debt'),
      ];
}
