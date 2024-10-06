import 'package:admin/controllers/hotel_controller.dart';
import 'package:admin/controllers/rootWidget.dart';
import 'package:admin/models/format_price.dart';
import 'package:admin/models/hotel.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/hotel/buyer_page.dart';
import 'package:admin/screens/hotel/hotel_buy_page.dart';
import 'package:admin/screens/hotel/hotel_page.dart';
import 'package:admin/screens/hotel/hotel_pay.dart';
import 'package:admin/screens/hotel/hotel_sale.dart';
import 'package:admin/screens/widgets/back_batten.dart';
import 'package:admin/utl/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        title: Header(title: widget.hotelId.hotelName!),
        actions: [
          BackBatten(
            onPressed: () {
              Provider.of<Rootwidget>(context, listen: false)
                  .getWidet(HotelPage());
            },
          )
        ],
      ),
      // body: !widget.showBuy
      //     ? HotelBuyPage(hotelId: widget.hotelId)
      //     : HotelSale(hotelId: widget.hotelId),
      body: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              Card(
                margin: EdgeInsets.all(defaultPadding),
                color: blueColor,
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(defaultPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (!widget.showBuy)
                              Text(
                                "اجمالي الغرف: ${widget.hotelId.rooms_total}",
                                style: TextStyle(fontSize: 20),
                              ),
                            Text(
                              "عدد الغرف المباعة: ${widget.hotelId.rooms}",
                              style: TextStyle(fontSize: 20),
                            ),
                            if (!widget.showBuy)
                              Text(
                                "عدد الغرف المتبقية: ${widget.hotelId.rooms_rest}",
                                style: TextStyle(fontSize: 20),
                              ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "التكلفة: ${widget.hotelId.price}",
                            style: TextStyle(fontSize: 20),
                          ),
                          // if (!widget.showBuy)
                          Text(
                            "الواصل: ${widget.hotelId.paid}",
                            style: TextStyle(fontSize: 20),
                          ),
                          // if (!widget.showBuy)
                          Text(
                            "الباقي: ${widget.hotelId.rest}",
                            style: TextStyle(
                                fontSize: 20,
                                color: double.parse(widget.hotelId.rest!) < 0
                                    ? Colors.red
                                    : null),
                          ),
                        ],
                      ),
                      if (!widget.showBuy)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "اجمالي تكلفة الشراء: ${widget.hotelId.price_total}",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "اجمالي تكلفة البيع: ${widget.hotelId.price}",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "الربح المتوقع: ${widget.hotelId.price_rest}",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      // Spacer(),
                      VerticalDivider(),
                      Consumer<HotelController>(
                          builder: (context, watch, child) => Text(
                                "مجموع الشراء الاجمالي \n${formatPrice(double.parse(watch.total_cost))}",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.center,
                              )),
                    ],
                  ),
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
