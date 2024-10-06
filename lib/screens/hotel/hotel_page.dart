import 'package:admin/screens/hotel/add_buy.dart';
import 'package:admin/screens/hotel/add_sale.dart';
import 'package:admin/screens/hotel/widgets/hotel_table_index.dart';
import 'package:admin/utl/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/hotel_controller.dart';

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
      // appBar: AppBar(
      //   title: Header(title: 'الفنادق'),
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(right: defaultPadding, top: defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
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
