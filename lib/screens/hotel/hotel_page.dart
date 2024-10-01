import 'package:admin/controllers/rootWidget.dart';
import 'package:admin/responsive.dart';
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
  // bool showMadinaHotelsBought = false;
  bool showMakkahHotelsSold = true;
  bool showMadinaHotelsSold = false;

  @override
  void initState() {
    super.initState();
    // Fetch initial data
    Provider.of<HotelController>(context, listen: false).fetchData(true, true);
    Provider.of<HotelController>(context, listen: false).fetchData(true, false);
    // Provider.of<HotelController>(context, listen: false).getFetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Header(title: 'الفنادق'),
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
                        .getWidet(HotelIndex());
                  },
                  child: Text('عرض الفنادق'),
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
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Column for Purchased Hotels
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.all(defaultPadding),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.end,
                      //     children: [
                      // ElevatedButton(
                      //   onPressed: () {
                      //     setState(() {
                      //       showMakkahHotelsBought = true;
                      //       // showMadinaHotelsBought = false;
                      //     });
                      //     Provider.of<HotelController>(context,
                      //             listen: false)
                      //         .fetchData(showMakkahHotelsBought);
                      //   },
                      //   child: Text('فنادق مكة - شراء'),
                      // ),
                      // SizedBox(width: defaultPadding),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     setState(() {
                      //       showMakkahHotelsBought = false;
                      //       // showMadinaHotelsBought = true;
                      //     });
                      //     Provider.of<HotelController>(context,
                      //             listen: false)
                      //         .fetchData(showMakkahHotelsBought);
                      //   },
                      //   child: Text('فنادق المدينة - شراء'),
                      // ),
                      //     ],
                      //   ),
                      // ),
                      Expanded(
                        child: Consumer<HotelController>(
                          builder:
                              (BuildContext context, value, Widget? child) {
                            if (value.isLading) {
                              return Center(child: CircularProgressIndicator());
                            }
                            return hotelTable(
                              value,
                              context,
                              value.hotelsPay,
                              // showMakkahHotelsBought
                              //     ? value.hotelsK
                              //     : !showMakkahHotelsBought
                              //         ? value.hotelsM
                              //         : [],
                              'فنادق تم شراؤها',
                              true,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                // Right Column for Sold Hotels
                if (!Responsive.isMobile(context))
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        // Padding(
                        //   padding: const EdgeInsets.all(defaultPadding),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.end,
                        //     children: [
                        //       ElevatedButton(
                        //         onPressed: () {
                        //           setState(() {
                        //             showMakkahHotelsSold = true;
                        //             showMadinaHotelsSold = false;
                        //           });
                        //         },
                        //         child: Text('فنادق مكة - بيع'),
                        //       ),
                        //       SizedBox(width: defaultPadding),
                        //       ElevatedButton(
                        //         onPressed: () {
                        //           setState(() {
                        //             showMakkahHotelsSold = false;
                        //             showMadinaHotelsSold = true;
                        //           });
                        //         },
                        //         child: Text('فنادق المدينة - بيع'),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        Expanded(
                          child: Consumer<HotelController>(
                            builder:
                                (BuildContext context, value, Widget? child) {
                              if (value.isLading) {
                                return Center(
                                    child: CircularProgressIndicator());
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
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
