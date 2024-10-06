import 'package:admin/controllers/hotel_controller.dart';
import 'package:admin/controllers/rootWidget.dart';
import 'package:admin/models/reseller.dart';
import 'package:admin/screens/hotel/hotel_page.dart';
import 'package:admin/screens/widgets/back_batten.dart';
import 'package:admin/screens/widgets/deleteDialog.dart';
import 'package:admin/screens/widgets/my_data_table.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HotelIndex extends StatefulWidget {
  const HotelIndex({super.key});

  @override
  State<HotelIndex> createState() => _HotelIndexState();
}

class _HotelIndexState extends State<HotelIndex> {
  @override
  void initState() {
    Provider.of<HotelController>(context, listen: false).getFetchData(true);
    Provider.of<HotelController>(context, listen: false).getFetchData(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('عرض الفنادق'),
        actions: [
          BackBatten(
            onPressed: () {
              Provider.of<Rootwidget>(context, listen: false)
                  .getWidet(HotelPage());
            },
          )
        ],
      ),
      body: Consumer<HotelController>(builder: (
        BuildContext context,
        HotelController hotelController,
        Widget? child,
      ) {
        return Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    "فنادق مكة",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  MyDataTable(
                      expended: true,
                      columns: [
                        DataColumn(label: Text('الاسم')),
                        DataColumn(label: Text('رقم الهاتف')),
                        DataColumn(label: Text('التاريخ')),
                        DataColumn(label: Text('الاجراء')),
                      ],
                      rows:
                          List.generate(hotelController.hotels.length, (index) {
                        Reseller hotelBuy = hotelController.hotels[index];
                        return DataRow(
                            color: WidgetStateProperty.all(Colors.white),
                            cells: [
                              DataCell(
                                Text(
                                  hotelBuy.fullName.toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              DataCell(
                                Text(
                                  hotelBuy.phoneNumber.toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              DataCell(
                                Text(
                                  hotelBuy.createdAt
                                      .toString()
                                      .substring(0, 10),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              DataCell(ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all(
                                      Colors.red,
                                    ),
                                    foregroundColor: WidgetStateProperty.all(
                                      Colors.white,
                                    ),
                                  ),
                                  onPressed: () {
                                    deleteDialog(context, () async {
                                      await hotelController.delete(
                                          hotelBuy.id!, context);
                                      hotelController.getFetchData(true);
                                    });
                                  },
                                  child: Text("حذف"))),
                            ]);
                      })),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    "فنادق المدينة",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  MyDataTable(
                      expended: true,
                      columns: [
                        DataColumn(label: Text('الاسم')),
                        DataColumn(label: Text('رقم الهاتف')),
                        DataColumn(label: Text('التاريخ')),
                        DataColumn(label: Text('الاجراء')),
                      ],
                      rows: List.generate(hotelController.hotels2.length,
                          (index) {
                        Reseller hotelBuy = hotelController.hotels2[index];
                        return DataRow(
                            color: WidgetStateProperty.all(Colors.white),
                            cells: [
                              DataCell(
                                Text(
                                  hotelBuy.fullName.toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              DataCell(
                                Text(
                                  hotelBuy.phoneNumber.toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              DataCell(
                                Text(
                                  hotelBuy.createdAt
                                      .toString()
                                      .substring(0, 10),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              DataCell(ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all(
                                      Colors.red,
                                    ),
                                    foregroundColor: WidgetStateProperty.all(
                                      Colors.white,
                                    ),
                                  ),
                                  onPressed: () {
                                    deleteDialog(context, () async {
                                      await hotelController.delete(
                                          hotelBuy.id!, context);
                                      hotelController.getFetchData(false);
                                    });
                                  },
                                  child: Text("حذف"))),
                            ]);
                      })),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
