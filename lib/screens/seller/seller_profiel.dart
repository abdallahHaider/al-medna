import 'package:admin/controllers/seller_controller.dart';
import 'package:admin/models/mybuyer.dart';
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
                Card(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                            width: double.maxFinite,
                            child: Card(
                                color: Colors.white,
                                child: Consumer<SellerController>(builder: (
                                  BuildContext context,
                                  accountsController,
                                  Widget? child,
                                ) {
                                  return DataTable(
                                    columns: [
                                      DataColumn(label: Text('المرسل')),
                                      DataColumn(label: Text('المبلغ بالريال')),
                                      DataColumn(
                                          label: Text('المبلغ بالدولار')),
                                      DataColumn(label: Text('ملاحضات')),
                                    ],
                                    rows: List.generate(
                                        accountsController.mySmallBank.length,
                                        (index) {
                                      MyBuyer mybuyer =
                                          accountsController.mySmallBank[index];
                                      return DataRow(cells: [
                                        DataCell(
                                          Text(mybuyer.buyer.toString()),
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
                                }))))),
                Card(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                            width: double.maxFinite,
                            child: Card(
                                color: Colors.white,
                                child: Consumer<SellerController>(builder: (
                                  BuildContext context,
                                  accountsController,
                                  Widget? child,
                                ) {
                                  return DataTable(
                                    columns: [
                                      DataColumn(label: Text('المرسل')),
                                      DataColumn(label: Text('المبلغ بالريال')),
                                      DataColumn(
                                          label: Text('المبلغ بالدولار')),
                                      DataColumn(label: Text('ملاحضات')),
                                    ],
                                    rows: List.generate(
                                        accountsController.mySmallBank2.length,
                                        (index) {
                                      MyBuyer mybuyer = accountsController
                                          .mySmallBank2[index];
                                      return DataRow(cells: [
                                        DataCell(
                                          Text(mybuyer.buyer.toString()),
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
                                }))))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
