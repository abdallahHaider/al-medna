class TypeAction {
  final String name;
  final String id;

  TypeAction({required this.name, required this.id});

  static List<TypeAction> get actions => [
        TypeAction(name: 'سند قبض', id: 'pay'),
        TypeAction(name: 'سند صرف', id: 'debt'),
      ];
}

class TypeAction4 {
  final String name;
  final String id;

  TypeAction4({required this.name, required this.id});

  static List<TypeAction4> get actions => [
        TypeAction4(name: 'وارد', id: 'pay'),
        TypeAction4(name: 'صادر', id: 'debt'),
      ];
}

class TypeAction2 {
  final String name;
  final String id;

  TypeAction2({required this.name, required this.id});

  static List<TypeAction2> get actions => [
        TypeAction2(name: 'ايداع', id: 'pay'),
        TypeAction2(name: 'حوالة', id: 'debt'),
      ];
}

class TypeAction3 {
  final String name;
  final String id;

  TypeAction3({required this.name, required this.id});

  static List<TypeAction3> get actions => [
        TypeAction3(name: 'البنك', id: 'f_bank'),
        TypeAction3(name: 'الصيرفة', id: 'f_small_bank'),
        TypeAction3(name: 'الخزنة', id: ''),
        TypeAction3(name: 'الشركات', id: ''),
      ];
}
