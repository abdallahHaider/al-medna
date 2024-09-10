import 'package:admin/models/format_price.dart';

class Hotel {
  int? id;
  String? hotelName;
  int? rooms;
  String? price;
  String? paid;
  String? rest;

  Hotel({
    this.id,
    this.hotelName,
    this.rooms,
    this.price,
    this.paid,
    this.rest,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) => Hotel(
        id: json["id"],
        hotelName: json["hotel_name"],
        rooms: json["rooms"],
        price: formatPrice(json["price"]),
        paid: formatPrice(json["paid"]),
        rest: formatPrice(json["rest"]),
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
