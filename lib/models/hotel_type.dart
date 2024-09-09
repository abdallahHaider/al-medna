class HotelType {
  final String name;
  HotelType({required this.name});
  static List<HotelType> get costs => [
        HotelType(name: 'مكة'),
        HotelType(name: 'المدينة'),
      ];
}
