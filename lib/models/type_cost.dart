class TypeCost {
  final String name;
  final String id;
  TypeCost({required this.name, required this.id});
  static List<TypeCost> get costs => [
        TypeCost(name: 'دينار', id: '1'),
        TypeCost(name: 'دولار', id: '2'),
      ];
}
