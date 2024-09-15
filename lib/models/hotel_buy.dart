import 'package:admin/models/format_price.dart';

class HotelBuy {
  int? id;
  String? hotelId;
  String? company;
  int? rooms;
  int? nights;
  String? roomPricePerNight;
  String? totalPrice;
  String? total_price_usd;
  String? total_price_ras;
  dynamic companyProgramId;
  dynamic reseller;
  String? curreny;
  String? buyer;
  String? buyerId;
  String? now_debt_ras;
  String? now_debt_usd;
  DateTime? createdAt;
  DateTime? updatedAt;

  HotelBuy({
    this.id,
    this.hotelId,
    this.company,
    this.rooms,
    this.nights,
    this.roomPricePerNight,
    this.totalPrice,
    this.total_price_usd,
    this.total_price_ras,
    this.companyProgramId,
    this.reseller,
    this.curreny,
    this.buyer,
    this.buyerId,
    this.now_debt_ras,
    this.now_debt_usd,
    this.createdAt,
    this.updatedAt,
  });

  factory HotelBuy.fromJson(Map<String, dynamic> json) => HotelBuy(
        id: json["id"],
        hotelId: json["hotel"],
        company: json["company"],
        rooms: json["rooms"],
        nights: json["nights"],
        roomPricePerNight: formatPrice(json["room_price_per_night"]),
        totalPrice: formatPrice(json["total_price"] ?? 0),
        total_price_usd: formatPrice(json["total_price_usd"] ?? 0),
        total_price_ras: formatPrice(json["total_price_ras"] ?? 0),
        companyProgramId: json["company_program_id"] ?? "",
        reseller: json["reseller"],
        curreny: json["curreny"],
        buyer: json["buyer"],
        buyerId: json["buyer_id"],
        // now_debt: formatPrice(json["now_debt"]),
        now_debt_ras: formatPrice(json["now_debt_ras"] ?? 0),
        now_debt_usd: formatPrice(json["now_debt_usd"] ?? 0),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "hotel_id": hotelId,
        "rooms": rooms,
        "nights": nights,
        "room_price_per_night": roomPricePerNight,
        "company_program_id": companyProgramId,
        "reseller_id": reseller,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
