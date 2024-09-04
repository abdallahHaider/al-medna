// To parse this JSON data, do
//
//     final companyy = companyyFromJson(jsonString);

import 'dart:convert';

Companyy companyyFromJson(String str) => Companyy.fromJson(json.decode(str));

String companyyToJson(Companyy data) => json.encode(data.toJson());

class Companyy {
  int companyId;
  int id;
  String groupNumber;
  int numberT;
  int priceT;
  int totalPriceT;
  String hotelName;
  int rooms;
  int nights;
  int roomPricePerNight;
  int totalPriceHotel;
  DateTime createdAt;

  Companyy({
    required this.companyId,
    required this.id,
    required this.groupNumber,
    required this.numberT,
    required this.priceT,
    required this.totalPriceT,
    required this.hotelName,
    required this.rooms,
    required this.nights,
    required this.roomPricePerNight,
    required this.totalPriceHotel,
    required this.createdAt,
  });

  factory Companyy.fromJson(Map<String, dynamic> json) => Companyy(
        companyId: json["company_id"],
        id: json["id"],
        groupNumber: json["group_number"],
        numberT: json["number_t"],
        priceT: json["price_t"],
        totalPriceT: json["total_price_t"],
        hotelName: json["hotel_name"],
        rooms: json["rooms"],
        nights: json["nights"],
        roomPricePerNight: json["room_price_per_night"],
        totalPriceHotel: json["total_price_hotel"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "company_id": companyId,
        "group_number": groupNumber,
        "number_t": numberT,
        "price_t": priceT,
        "total_price_t": totalPriceT,
        "hotel_name": hotelName,
        "rooms": rooms,
        "nights": nights,
        "room_price_per_night": roomPricePerNight,
        "total_price_hotel": totalPriceHotel,
        "created_at": createdAt.toIso8601String(),
      };
}
