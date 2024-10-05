import 'package:admin/controllers/rootWidget.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/hotel/add_buy.dart';
import 'package:admin/screens/hotel/add_sale.dart';
import 'package:admin/screens/hotel/hotel_index.dart';
import 'package:admin/screens/hotel/widgets/add_hotel.dart';
import 'package:admin/screens/hotel/widgets/hotel_table_index.dart';
import 'package:admin/screens/seller/seller_page.dart';
import 'package:admin/utl/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/hotel_controller.dart';
import '../dashboard/components/header.dart';

class HotelPage extends StatefulWidget {
  @override
  State<HotelPage> createState() => _HotelPageState();
}

class _HotelPageState extends State<HotelPage> {
  bool showMakkahHotelsSold = true;
  bool showMadinaHotelsSold = false;

  @override
  void initState() {
    super.initState();
    Provider.of<HotelController>(context, listen: false).fetchData(true, true);
    Provider.of<HotelController>(context, listen: false).fetchData(true, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Header(title: 'الفنادق'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Show add hotel form
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              child: addHotelForm(context),
                            );
                          },
                        );
                      },
                      child: Text('إضافة فندق'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Provider.of<Rootwidget>(context, listen: false)
                            .getWidet(sellerPage());
                      },
                      child: Text('إضافة مشتري'),
                    ),
                  ],
                ),
              ),
              SizedBox(child: AddBuy()),
              Divider(),
              SizedBox(child: AddSale()),
              Divider(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Consumer<HotelController>(
                          builder:
                              (BuildContext context, value, Widget? child) {
                            if (value.isLading) {
                              return Center(child: CircularProgressIndicator());
                            }
                            return hotelTable(
                              value,
                              context,
                              value.hotelsPay,
                              'فنادق تم شراؤها',
                              true,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Consumer<HotelController>(
                          builder:
                              (BuildContext context, value, Widget? child) {
                            if (value.isLading) {
                              return Center(child: CircularProgressIndicator());
                            }
                            return hotelTable(
                              value,
                              context,
                              showMakkahHotelsSold
                                  ? value.hotelsSale
                                  : showMadinaHotelsSold
                                      ? value.hotelsSale
                                      : [],
                              'فنادق مباعة',
                              false,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
