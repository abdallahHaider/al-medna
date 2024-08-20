class TypeAction {
  final String name;
  final String id;

  TypeAction({required this.name, required this.id});

  static List<TypeAction> get actions => [
        TypeAction(name: 'سند قبض', id: '1'),
        TypeAction(name: 'سند صرف', id: '2'),
      ];
}
