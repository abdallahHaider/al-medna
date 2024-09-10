import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/hotel/widgets/hotel_buy_page.dart';
import 'package:admin/screens/hotel/widgets/hotel_sale.dart';
import 'package:flutter/material.dart';

/// صفحة الام للفنادق والجذر الاساسي
class HotelProfile extends StatefulWidget {
  const HotelProfile({super.key, required this.hotelId, required this.showBuy});

  final String hotelId;
  final bool showBuy; // true for buying hotels, false for selling hotels

  @override
  State<HotelProfile> createState() => _HotelProfileState();
}

class _HotelProfileState extends State<HotelProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Header(title: "حساب الفندق"),
      ),
      body: widget.showBuy 
        ? HotelBuyPage(hotelId: widget.hotelId) 
        : HotelSale(hotelId: widget.hotelId),
    );
  }
}
