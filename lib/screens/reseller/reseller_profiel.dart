import 'package:admin/controllers/reseller_controller.dart';
import 'package:admin/models/reseller.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/reseller/widgets/cardResellerDetels.dart';
import 'package:admin/screens/trap/widget/dataBelder.dart';
import 'package:admin/utl/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResellerProfiel extends StatelessWidget {
  const ResellerProfiel({super.key, required this.resellerID});
  final Reseller resellerID;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Header(title: "تفاصيل الوكيل"),
              SizedBox(
                height: defaultPadding,
              ),
              cardResellerDetels(resellerID),
              TabBar(
                  isScrollable: true,
                  tabs: [Tab(text: "الرحلات"), Tab(text: "كشف الحساب")]),
              Expanded(
                child: TabBarView(children: [
                  Consumer<ResellerController>(
                      builder: (context, resellerProvider, child) {
                    resellerProvider.getResellerinfo(resellerID.id.toString());
                    return FutureBuilder(
                        future: resellerProvider
                            .getResellerinfo(resellerID.id.toString()),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text(snapshot.error.toString());
                          } else if (snapshot.hasData) {
                            return TrapTable(traps: snapshot.data!);
                            // return SizedBox(
                            //   // height: double.maxFinite,
                            //   width: double.infinity,
                            //   child: DataTable(
                            //     columnSpacing: defaultPadding,
                            //     columns: [
                            //       DataColumn(
                            //         label: Text("اسم الوكيل"),
                            //       ),
                            //       DataColumn(
                            //         label: Text(" نوع الرحلة"),
                            //       ),
                            //       DataColumn(
                            //         label: Text(" الايام"),
                            //       ),
                            //       DataColumn(
                            //         label: Text("عدد المسافرين"),
                            //       ),
                            //       DataColumn(
                            //         label: Text("السعر لكل مسافر"),
                            //       ),
                            //       DataColumn(
                            //         label: Text("سعر الصرف"),
                            //       ),
                            //     ],
                            //     rows: List.generate(
                            //         snapshot.data!.length,
                            //         (index) => DataRow(cells: [
                            //               DataCell(
                            //                 Text(
                            //                   snapshot.data![index].resellerId
                            //                       .toString(),
                            //                 ),
                            //               ),
                            //               DataCell(
                            //                 Text(
                            //                   snapshot.data![index].transport
                            //                               .toString() ==
                            //                           "fly"
                            //                       ? "جوي"
                            //                       : "بري",
                            //                 ),
                            //               ),
                            //               DataCell(
                            //                 Text(
                            //                   snapshot.data![index].duration
                            //                       .toString(),
                            //                 ),
                            //               ),
                            //               DataCell(
                            //                 Text(
                            //                   snapshot.data![index].quantity
                            //                       .toString(),
                            //                 ),
                            //               ),
                            //               DataCell(
                            //                 Text(
                            //                   snapshot.data![index].pricePerOne
                            //                       .toString(),
                            //                 ),
                            //               ),
                            //               DataCell(
                            //                 Text(
                            //                   snapshot.data![index].iqdToUsd
                            //                       .toString(),
                            //                 ),
                            //               ),
                            //             ])),
                            //   ),
                            // );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        });
                  }),
                  Consumer<ResellerController>(
                      builder: (context, resellerProvider, child) {
                    return FutureBuilder(
                        future: resellerProvider
                            .getDbetPayinfo(resellerID.id.toString()),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text(snapshot.error.toString());
                          } else if (snapshot.hasData) {
                            
                            return Card(
                              // height: double.maxFinite,
                              // width: double.infinity,
                              color: secondaryColor,
                              elevation: 5,
                              margin: EdgeInsets.all(defaultPadding),
                              child: DataTable(
                                columnSpacing: defaultPadding,
                                columns: [
                                  DataColumn(
                                    label: Text("اسم الوكيل"),
                                  ),
                                  DataColumn(
                                    label: Text("رقم الوصل"),
                                  ),
                                  DataColumn(
                                    label: Text("المبلغ"),
                                  ),
                                     DataColumn(
                                    label: Text("سعر الصرف"),
                                  ),
                                  DataColumn(
                                    label: Text("التاريخ"),
                                  ),
                                ],
                                rows: List.generate(
                                    snapshot.data!.length,
                                    (index) => DataRow(
                                      cells: [
                                          DataCell(
                                            Text(
                                              snapshot.data![index].resellerId
                                                  .toString(),
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              snapshot.data![index].id
                                                  .toString(),
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              snapshot.data![index].cost
                                                  .toString(),
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              snapshot.data![index].iqdToUsd
                                                  .toString(),
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              snapshot.data![index].createdAt
                                                  .toString()
                                                  .substring(0, 10),
                                            ),
                                          ),
                                        ])),
                              ),
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        });
                  })
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
