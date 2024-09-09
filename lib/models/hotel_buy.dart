class HotelBuy {
  int? id;
  String? hotelId;
  String? company;
  int? rooms;
  int? nights;
  double? roomPricePerNight;
  double? totalPrice;
  dynamic companyProgramId;
  dynamic resellerId;
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
    this.companyProgramId,
    this.resellerId,
    this.createdAt,
    this.updatedAt,
  });

  factory HotelBuy.fromJson(Map<String, dynamic> json) => HotelBuy(
        id: json["id"],
        hotelId: json["hotel"],
        company: json["company"],
        rooms: json["rooms"],
        nights: json["nights"],
        roomPricePerNight: json["room_price_per_night"],
        totalPrice: json["total_price"],
        companyProgramId: json["company_program_id"] ?? "",
        resellerId: json["reseller_id"],
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
        "reseller_id": resellerId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
