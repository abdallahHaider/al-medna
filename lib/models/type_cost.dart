class TypeCost {
  final String name;
  final String id;
  TypeCost({required this.name, required this.id});
  static List<TypeCost> get costs => [
        TypeCost(name: 'دينار', id: '1'),
        TypeCost(name: 'دولار', id: '2'),
      ];
}

class TypeCost2 {
  final String name;
  final String id;
  TypeCost2({required this.name, required this.id});
  static List<TypeCost2> get costs => [
        TypeCost2(name: 'ريال', id: 'ras'),
        TypeCost2(name: 'دولار', id: 'usd'),
      ];
}
