import 'dart:convert';

import 'package:admin/models/format_price.dart';

Trap trapFromJson(String str) => Trap.fromJson(json.decode(str));

String trapToJson(Trap data) => json.encode(data.toJson());

class Trap {
  int? id;
  String? resellerId;
  String? hotelId;
  String? duration;
  String? quantity;
  String? price;
  String? coupleRoom;
  String? tripleRoom;
  String? quadrupleRoom;
  String? child;
  String? veryChild;
  String? priceCoupleRoom;
  String? priceTripleRoom;
  String? priceQuadrupleRoom;
  String? priceChild;
  String? priceVeryChild;
  String? pricePerOne;
  int? rasToUsd;
  int? iqdToUsd;
  String? type;
  String? transport;
  DateTime? createdAt;
  String? nowDebt;
  String? note;
  int? vip_travel;
  String? price_vip_travel;
  int? number_trap;

  Trap({
    this.id,
    this.resellerId,
    this.hotelId,
    this.duration,
    this.quantity,
    this.price,
    this.coupleRoom,
    this.tripleRoom,
    this.quadrupleRoom,
    this.child,
    this.type,
    this.veryChild,
    this.priceCoupleRoom,
    this.priceTripleRoom,
    this.priceQuadrupleRoom,
    this.priceChild,
    this.priceVeryChild,
    this.pricePerOne,
    this.rasToUsd,
    this.iqdToUsd,
    this.transport,
    this.createdAt,
    this.nowDebt,
    this.note,
    this.vip_travel,
    this.price_vip_travel,
    this.number_trap,
  });

  factory Trap.fromJson(Map<String, dynamic> json) => Trap(
        id: json["id"],
        resellerId: json["reseller_id"].toString(),
        hotelId: json["hotel_id"].toString(),
        duration: json["duration"].toString(),
        quantity: json["quantity"].toString(),
        price: json["price"] == null ? null : formatPrice(json["price"]),
        coupleRoom: json["couple_room"].toString(),
        tripleRoom: json["triple_room"].toString(),
        quadrupleRoom: json["quadruple_room"].toString(),
        child: json["child"].toString(),
        veryChild: json["very_child"].toString(),
        priceCoupleRoom: json["price_couple_room"] == null
            ? null
            : formatPrice(json["price_couple_room"]),
        priceTripleRoom: json["price_triple_room"] == null
            ? null
            : formatPrice(json["price_triple_room"]),
        priceQuadrupleRoom: json["price_quadruple_room"] == null
            ? null
            : formatPrice(json["price_quadruple_room"]),
        priceChild: json["price_child"] == null
            ? null
            : formatPrice(json["price_child"]),
        priceVeryChild: json["price_very_child"] == null
            ? null
            : formatPrice(json["price_very_child"]),
        // pricePerOne: double.parse(json["price_per_one"].toString()),
        rasToUsd: json["RAS_to_USD"],
        iqdToUsd: json["IQD_to_USD"],
        transport: json["transport"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        nowDebt: formatPrice(json["now_debt"]),
        type: json["type"],
        note: json["note"].toString(),
        vip_travel: json["vip_travel"],
        price_vip_travel: json["price_vip_travel"] == null
            ? null
            : formatPrice(json["price_vip_travel"]),
        number_trap: json["number_trap"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "reseller_id": resellerId,
        "hotel_id": hotelId,
        "duration": duration,
        "quantity": quantity,
        "price": price,
        "couple_room": coupleRoom,
        "triple_room": tripleRoom,
        "quadruple_room": quadrupleRoom,
        "child": child,
        "very_child": veryChild,
        "price_couple_room": priceCoupleRoom,
        "price_triple_room": priceTripleRoom,
        "price_quadruple_room": priceQuadrupleRoom,
        "price_child": priceChild,
        "price_very_child": priceVeryChild,
        "price_per_one": pricePerOne,
        "RAS_to_USD": rasToUsd,
        "IQD_to_USD": iqdToUsd,
        "transport": transport,
        "created_at": createdAt,
      };
}
