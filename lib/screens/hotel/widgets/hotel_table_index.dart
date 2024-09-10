import 'package:admin/controllers/hotel_controller.dart';
import 'package:admin/controllers/rootWidget.dart';
import 'package:admin/models/hotel.dart';
import 'package:admin/screens/hotel/add_buy.dart';
import 'package:admin/screens/hotel/add_sale.dart';
import 'package:admin/screens/hotel/hotel_profile.dart';
import 'package:admin/utl/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Card hotelTable(HotelController value, BuildContext context, List hotels,
    String title, bool isBuying) {
  bool showMakkahHotelsBought = true;
  return Card(
    elevation: 5,
    color: secondaryColor,
    margin: EdgeInsets.all(defaultPadding),
    child: SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Row(
              children: [
                Consumer<HotelController>(
                    builder: (BuildContext context, value, Widget? child) {
                  return Text(
                    isBuying
                        ? "$title  -  ${value.isMagk ? "مكة" : "مدينة"}"
                        : "$title  -  ${value.isMagk2 ? "مكة" : "مدينة"}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  );
                }),
                Spacer(),
                ElevatedButton(
                    onPressed: () {
                      if (isBuying) {
                        Provider.of<Rootwidget>(context, listen: false)
                            .getWidet(AddBuy());
                      } else {
                        Provider.of<Rootwidget>(context, listen: false)
                            .getWidet(AddSale());
                      }
                    },
                    child: isBuying ? Text("اضافة شراء") : Text("اضافة بيع"))
              ],
            ),
          ),
          Row(children: [
            ElevatedButton(
              onPressed: () {
                // setState(() {
                showMakkahHotelsBought = false;
                //   // showMadinaHotelsBought = true;
                // });
                isBuying
                    ? Provider.of<HotelController>(context, listen: false)
                        .isMagk = false
                    : Provider.of<HotelController>(context, listen: false)
                        .isMagk2 = false;
                Provider.of<HotelController>(context, listen: false)
                    .fetchData(showMakkahHotelsBought, isBuying);
              },
              child: Text('فنادق المدينة'),
            ),
            SizedBox(width: defaultPadding),
            ElevatedButton(
              onPressed: () {
                // setState(() {
                showMakkahHotelsBought = true;
                //   // showMadinaHotelsBought = false;
                // });
                isBuying
                    ? Provider.of<HotelController>(context, listen: false)
                        .isMagk = true
                    : Provider.of<HotelController>(context, listen: false)
                        .isMagk2 = true;
                Provider.of<HotelController>(context, listen: false)
                    .fetchData(showMakkahHotelsBought, isBuying);
              },
              child: Text('فنادق مكة'),
            ),
          ]),
          SizedBox(height: defaultPadding),
          Container(
            width: double.maxFinite,
            color: Colors.grey,
            child: DataTable(
              border: TableBorder.all(
                  width: 1, style: BorderStyle.solid, color: Colors.grey),
              dataRowColor: WidgetStateProperty.all(Colors.white),
              columns: [
                DataColumn(label: Text('اسم الفندق')),
                DataColumn(label: Text('عدد الغرف')),
                DataColumn(label: Text('التكلفة')),
                DataColumn(label: Text('الواصل ')),
                DataColumn(label: Text('الباقي ')),
              ],
              rows: List.generate(hotels.length, (index) {
                Hotel hotel = hotels[index];
                return DataRow(cells: [
                  DataCell(
                    TextButton(
                      onPressed: () {
                        Provider.of<Rootwidget>(context, listen: false)
                            .getWidet(HotelProfile(
                          hotelId: hotel.id.toString(),
                          showBuy: isBuying,
                        ));
                      },
                      child: Text(
                        hotel.hotelName.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  DataCell(
                    Text(
                      hotel.rooms!.toString(),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  DataCell(
                    Text(
                      hotel.price!,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  DataCell(
                    Text(
                      hotel.paid!,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  DataCell(
                    Text(
                      hotel.rest!,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  // DataCell(ElevatedButton(
                  //     style: ButtonStyle(
                  //       backgroundColor: MaterialStateProperty.all(
                  //         Colors.red,
                  //       ),
                  //       foregroundColor: MaterialStateProperty.all(
                  //         Colors.white,
                  //       ),
                  //     ),
                  //     onPressed: () {
                  //       deleteHotel(context, hotel, index);
                  //     },
                  //     child: Text("حذف"))),
                ]);
              }),
            ),
          ),
        ],
      ),
    ),
  );
}
