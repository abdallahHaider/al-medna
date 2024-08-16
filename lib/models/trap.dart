// // To parse this JSON data, do
// //
// //     final trap = trapFromJson(jsonString);

// import 'dart:convert';

// Trap trapFromJson(String str) => Trap.fromJson(json.decode(str));

// String trapToJson(Trap data) => json.encode(data.toJson());

// class Trap {
//   int? id;
//   String? resellerId;
//   String? hotelId;
//   int? duration;
//   int? quantity;
//   double pricePerOne;
//   double rasToUsd;
//   double iqdToUsd;
//   String? transport;
//   DateTime? createdAt;

//   Trap({
//     this.id,
//     this.resellerId,
//     this.hotelId,
//     this.duration,
//     this.quantity,
//   required  this.pricePerOne,
//   required  this.rasToUsd,
//    required this.iqdToUsd,
//     this.transport,
//     this.createdAt,
//   });

//   factory Trap.fromJson(Map<String, dynamic> json) => Trap(
//     id: json["id"],
//     resellerId: json["reseller_id"],
//     hotelId: json["hotel_id"],
//     duration: json["duration"],
//     quantity: json["quantity"],
//     pricePerOne: json["price_per_one"],
//     rasToUsd: json["RAS_to_USD"],
//     iqdToUsd: json["IQD_to_USD"],
//     transport: json["transport"],
//     createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//   );

//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "reseller_id": resellerId,
//     "hotel_id": hotelId,
//     "duration": duration,
//     "quantity": quantity,
//     "price_per_one": pricePerOne,
//     "RAS_to_USD": rasToUsd,
//     "IQD_to_USD": iqdToUsd,
//     "transport": transport,
//     "created_at": createdAt?.toIso8601String(),
//   };
// }

// To parse this JSON data, do
//
//     final trap = trapFromJson(jsonString);

import 'dart:convert';

Trap trapFromJson(String str) => Trap.fromJson(json.decode(str));

String trapToJson(Trap data) => json.encode(data.toJson());

class Trap {
    int? id;
    String? resellerId;
    String? hotelId;
    int? duration;
    int? quantity;
    int? price;
    int? coupleRoom;
    int? tripleRoom;
    int? quadrupleRoom;
    int? child;
    int? veryChild;
    int? priceCoupleRoom;
    int? priceTripleRoom;
    int? priceQuadrupleRoom;
    int? priceChild;
    int? priceVeryChild;
    int? pricePerOne;
    int? rasToUsd;
    int? iqdToUsd;
    String? transport;
    DateTime? createdAt;

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
    });

    factory Trap.fromJson(Map<String, dynamic> json) => Trap(
        id: json["id"],
        resellerId: json["reseller_id"].toString(),
        hotelId: json["hotel_id"].toString(),
        duration: json["duration"],
        quantity: json["quantity"],
        price: json["price"],
        coupleRoom: json["couple_room"],
        tripleRoom: json["triple_room"],
        quadrupleRoom: json["quadruple_room"],
        child: json["child"],
        veryChild: json["very_child"],
        priceCoupleRoom: json["price_couple_room"],
        priceTripleRoom: json["price_triple_room"],
        priceQuadrupleRoom: json["price_quadruple_room"],
        priceChild: json["price_child"],
        priceVeryChild: json["price_very_child"],
        pricePerOne: json["price_per_one"],
        rasToUsd: json["RAS_to_USD"],
        iqdToUsd: json["IQD_to_USD"],
        transport: json["transport"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
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

