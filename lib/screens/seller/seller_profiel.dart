import 'package:admin/controllers/seller_controller.dart';
import 'package:admin/models/hotel_buy.dart';
import 'package:admin/models/mybuyer.dart';
import 'package:admin/screens/widgets/my_data_table.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SellerProfile extends StatefulWidget {
  const SellerProfile({super.key, required this.id});
  final String id;

  @override
  State<SellerProfile> createState() => _SellerProfileState();
}

class _SellerProfileState extends State<SellerProfile> {
  @override
  void initState() {
    Provider.of<SellerController>(context, listen: false).getCompany(widget.id);
    Provider.of<SellerController>(context, listen: false)
        .getBuyerPay(widget.id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(isScrollable: true, tabs: const [
            Tab(
              text: 'التسديدات',
            ),
            Tab(
              text: 'المشتريات',
            ),
          ]),
          Expanded(
            child: TabBarView(
              children: [
                Consumer<SellerController>(builder: (
                  BuildContext context,
                  accountsController,
                  Widget? child,
                ) {
                  return MyDataTable(
                    expended: true,
                    columns: [
                      DataColumn(label: Text('المرسل')),
                      DataColumn(label: Text('الفندق')),
                      DataColumn(label: Text('المبلغ بالريال')),
                      DataColumn(label: Text('المبلغ بالدولار')),
                      DataColumn(label: Text('ملاحضات')),
                    ],
                    rows: List.generate(accountsController.mySmallBank.length,
                        (index) {
                      MyBuyer mybuyer = accountsController.mySmallBank[index];
                      return DataRow(
                          color: WidgetStateProperty.all(Colors.white),
                          cells: [
                            DataCell(
                              Text(mybuyer.buyer.toString()),
                            ),
                            DataCell(
                              Text(mybuyer.hotel_name.toString()),
                            ),
                            DataCell(
                              Text(mybuyer.costRas.toString()),
                            ),
                            DataCell(
                              Text(mybuyer.costUsd.toString()),
                            ),
                            DataCell(
                              Text(mybuyer.note.toString()),
                            ),
                          ]);
                    }),
                  );
                }),
                Consumer<SellerController>(builder: (
                  BuildContext context,
                  accountsController,
                  Widget? child,
                ) {
                  return MyDataTable(
                    expended: true,
                    columns: [
                      DataColumn(label: Text('الفندق')),
                      DataColumn(label: Text('الغرف')),
                      DataColumn(label: Text('الليالي')),
                      DataColumn(label: Text('سعر االيلة')),
                      DataColumn(label: Text('المتبقي')),
                      DataColumn(label: Text('الاجمالي')),
                      DataColumn(label: Text('تاريخ')),
                    ],
                    rows: List.generate(accountsController.mySmallBank2.length,
                        (index) {
                      HotelBuy mybuyer = accountsController.mySmallBank2[index];
                      return DataRow(
                          color: WidgetStateProperty.all(Colors.white),
                          cells: [
                            DataCell(
                              Text(mybuyer.hotelId.toString()),
                            ),
                            DataCell(
                              Text(mybuyer.rooms.toString()),
                            ),
                            DataCell(
                              Text(mybuyer.nights.toString()),
                            ),
                            DataCell(
                              Text(mybuyer.roomPricePerNight.toString()),
                            ),
                            DataCell(
                              Text(mybuyer.now_debt_usd.toString()),
                            ),
                            DataCell(
                              Text(mybuyer.totalPrice.toString()),
                            ),
                            DataCell(
                              Text(mybuyer.createdAt
                                  .toString()
                                  .substring(0, 10)),
                            ),
                          ]);
                    }),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
