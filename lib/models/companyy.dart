// // To parse this JSON data, do
// //
// //     final companyy = companyyFromJson(jsonString);

// import 'dart:convert';

// Companyy companyyFromJson(String str) => Companyy.fromJson(json.decode(str));

// String companyyToJson(Companyy data) => json.encode(data.toJson());

// class Companyy {
//   int companyId;
//   int id;
//   String groupNumber;
//   int numberT;
//   int priceT;
//   int totalPriceT;
//   // String hotelName;
//   // int rooms;
//   // int nights;
//   // int roomPricePerNight;
//   int totalPriceHotel;
//   DateTime createdAt;

//   Companyy({
//     required this.companyId,
//     required this.id,
//     required this.groupNumber,
//     required this.numberT,
//     required this.priceT,
//     required this.totalPriceT,
//     // required this.hotelName,
//     // required this.rooms,
//     // required this.nights,
//     // required this.roomPricePerNight,
//     required this.totalPriceHotel,
//     required this.createdAt,
//   });

//   factory Companyy.fromJson(Map<String, dynamic> json) => Companyy(
//         companyId: json["company_id"],
//         id: json["id"],
//         groupNumber: json["group_number"],
//         numberT: json["number_t"],
//         priceT: json["price_t"],
//         totalPriceT: json["total_price_t"],
//         // hotelName: json["hotel_name"],
//         // rooms: json["rooms"],
//         // nights: json["nights"],
//         // roomPricePerNight: json["room_price_per_night"],
//         totalPriceHotel: json["total_price_hotel"],
//         createdAt: DateTime.parse(json["created_at"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "company_id": companyId,
//         "group_number": groupNumber,
//         "number_t": numberT,
//         "price_t": priceT,
//         "total_price_t": totalPriceT,
//         // "hotel_name": hotelName,
//         // "rooms": rooms,
//         // "nights": nights,
//         // "room_price_per_night": roomPricePerNight,
//         "total_price_hotel": totalPriceHotel,
//         "created_at": createdAt.toIso8601String(),
//       };
// }

// To parse this JSON data, do
//
//     final companyy = companyyFromJson(jsonString);

import 'dart:convert';

import 'package:admin/models/format_price.dart';

Companyy companyyFromJson(String str) => Companyy.fromJson(json.decode(str));

String companyyToJson(Companyy data) => json.encode(data.toJson());

class Companyy {
  int? id;
  int? companyId;
  String? groupNumber;
  int? numberT;
  String? priceT;
  String? hotelName;
  int? rooms;
  int? nights;
  String? roomPricePerNight;
  String? hotelNameMaka;
  int? roomsMaka;
  int? nightsMaka;
  String? roomPricePerNightMaka;
  String? totalPriceT;
  String? totalPriceHotel;
  String? total_price;
  DateTime? createdAt;

  Companyy({
    this.id,
    this.companyId,
    this.groupNumber,
    this.numberT,
    this.priceT,
    this.hotelName,
    this.rooms,
    this.nights,
    this.roomPricePerNight,
    this.hotelNameMaka,
    this.roomsMaka,
    this.nightsMaka,
    this.roomPricePerNightMaka,
    this.totalPriceT,
    this.totalPriceHotel,
    this.total_price,
    this.createdAt,
  });

  factory Companyy.fromJson(Map<String, dynamic> json) => Companyy(
        id: json["id"],
        companyId: json["company_id"],
        groupNumber: json["group_number"],
        numberT: json["number_t"],
        priceT: formatPrice(json["price_t"]),
        hotelName: json["hotel_name"],
        rooms: json["rooms"],
        nights: json["nights"],
        roomPricePerNight: formatPrice(json["room_price_per_night"]),
        hotelNameMaka: json["hotel_name_maka"],
        roomsMaka: json["rooms_maka"],
        nightsMaka: json["nights_maka"],
        roomPricePerNightMaka: formatPrice(json["room_price_per_night_maka"]),
        totalPriceT: formatPrice(json["total_price_t"]),
        totalPriceHotel: formatPrice(json["total_price_hotel"]),
        total_price: formatPrice(json["total_price"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company_id": companyId,
        "group_number": groupNumber,
        "number_t": numberT,
        "price_t": priceT,
        "hotel_name": hotelName,
        "rooms": rooms,
        "nights": nights,
        "room_price_per_night": roomPricePerNight,
        "hotel_name_maka": hotelNameMaka,
        "rooms_maka": roomsMaka,
        "nights_maka": nightsMaka,
        "room_price_per_night_maka": roomPricePerNightMaka,
        "total_price_t": totalPriceT,
        "total_price_hotel": totalPriceHotel,
        "created_at": createdAt?.toIso8601String(),
      };
}
