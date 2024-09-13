import 'package:admin/models/hotel.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/hotel/buyer_page.dart';
import 'package:admin/screens/hotel/hotel_buy_page.dart';
import 'package:admin/screens/hotel/hotel_pay.dart';
import 'package:admin/screens/hotel/hotel_sale.dart';
import 'package:admin/utl/constants.dart';
import 'package:flutter/material.dart';

/// صفحة الام للفنادق والجذر الاساسي
class HotelProfile extends StatefulWidget {
  const HotelProfile({super.key, required this.hotelId, required this.showBuy});

  final Hotel hotelId;
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
      // body: !widget.showBuy
      //     ? HotelBuyPage(hotelId: widget.hotelId)
      //     : HotelSale(hotelId: widget.hotelId),
      body: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(defaultPadding),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "اسم الفندق: ${widget.hotelId.hotelName}",
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          "عدد الغرف: ${widget.hotelId.rooms}",
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          "التكلفة: ${widget.hotelId.price}",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "الواصل: ${widget.hotelId.paid}",
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          "الباقي: ${widget.hotelId.rest}",
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(""),
                      ],
                    )
                  ],
                ),
              ),
              TabBar(
                isScrollable: true,
                tabs: [
                  if (!widget.showBuy) Tab(text: "البيع"),
                  if (widget.showBuy) Tab(text: "الشراء"),
                  Tab(text: "التسديدات"),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    if (!widget.showBuy)
                      HotelSale(hotelId: widget.hotelId.id.toString()),
                    if (widget.showBuy)
                      HotelBuyPage(hotelId: widget.hotelId.id.toString()),
                    if (widget.showBuy)
                      HotelPay(hotelID: widget.hotelId.id.toString()),
                    if (!widget.showBuy)
                      BuyerPage(hotelID: widget.hotelId.id.toString()),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
