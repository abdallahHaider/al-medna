import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/hotel/widgets/hotel_buy_page.dart';
import 'package:admin/screens/hotel/widgets/hotel_pay.dart';
import 'package:admin/screens/hotel/widgets/hotel_sale.dart';
import 'package:flutter/material.dart';

class HotelProfile extends StatefulWidget {
  const HotelProfile({super.key, required this.hotelId});

  final String hotelId;

  @override
  State<HotelProfile> createState() => _HotelProfileState();
}

class _HotelProfileState extends State<HotelProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Header(title: ""),
        ),
        body: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              TabBar(
                  isScrollable: true,
                  physics: ScrollPhysics(parent: BouncingScrollPhysics()),
                  tabs: [
                    Tab(text: "التسديدات"),
                    Tab(text: "شراء الفنادق"),
                    Tab(text: "بيع الفنادق"),
                  ]),
              Expanded(
                child: TabBarView(
                  children: [
                    HotelPay(),
                    HotelBuyPage(
                      hotelId: widget.hotelId,
                    ),
                    HotelSale(
                      hotelId: widget.hotelId,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
