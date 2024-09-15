import 'package:admin/models/format_price.dart';

class Hotel {
  int? id;
  String? hotelName;
  int? rooms;
  String? price;
  String? paid;
  String? rest;
  String? rooms_total;
  String? rooms_rest;
  String? price_total;
  String? price_rest;

  Hotel({
    this.id,
    this.hotelName,
    this.rooms,
    this.price,
    this.paid,
    this.rest,
    this.rooms_total,
    this.rooms_rest,
    this.price_total,
    this.price_rest,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) => Hotel(
        id: json["id"],
        hotelName: json["hotel_name"],
        rooms: json["rooms"],
        price: formatPrice(json["price"] ?? 0),
        paid: formatPrice(json["paid"] ?? 0),
        rest: formatPrice(json["rest"] ?? 0),
        rooms_total: formatPrice(json["rooms_total"] ?? 0),
        rooms_rest: formatPrice(json["rooms_rest"] ?? 0),
        price_total: formatPrice(json["price_total"] ?? 0),
        price_rest: formatPrice(json["price_rest"] ?? 0),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "hotel_name": hotelName,
        "rooms": rooms,
        "price": price,
        "paid": paid,
        "rest": rest,
      };
}
