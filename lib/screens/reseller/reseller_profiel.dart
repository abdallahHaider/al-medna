import 'package:admin/controllers/reseller_controller.dart';
import 'package:admin/models/reseller.dart';
import 'package:admin/models/reseller_dbet.dart';
import 'package:admin/pdf/reseller_Pdf.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/reseller/widgets/cardResellerDetels.dart';
import 'package:admin/screens/reseller/widgets/trap_tibel.dart';
import 'package:admin/screens/widgets/snakbar.dart';
import 'package:admin/utl/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';

class ResellerProfiel extends StatefulWidget {
  const ResellerProfiel({super.key, required this.resellerID});
  final Reseller resellerID;

  @override
  State<ResellerProfiel> createState() => _ResellerProfielState();
}

class _ResellerProfielState extends State<ResellerProfiel> {
  @override
  void initState() {
    Provider.of<ResellerController>(context, listen: false).resellerDbet =
        ResellerDbet(
      countPays: 0,
      countTrap: 0,
      totalCostUsd: "0",
      totalCostUsdPays: "0",
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ResellerController>(context, listen: false)
        .getResellerinfodebt(widget.resellerID.id.toString());
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
              cardResellerDetels(widget.resellerID),
              Row(
                children: [
                  Expanded(
                    child: TabBar(isScrollable: true, tabs: [
                      Tab(text: "الرحلات"),
                      // Tab(text: "كشف الحساب")
                    ]),
                  ),
                  TextButton.icon(
                    onPressed: () async {
                      try {
                        SmartDialog.showLoading();
                        var globlDebt = await Provider.of<ResellerController>(
                                context,
                                listen: false)
                            .resellerDbet;
                        List traps = await Provider.of<ResellerController>(
                                context,
                                listen: false)
                            .getResellerinfo(widget.resellerID.id.toString());
                        await ResellerToPdf(
                            widget.resellerID, globlDebt, traps);
                      } catch (e) {
                        snackBar(context, e.toString(), true);
                      } finally {
                        SmartDialog.dismiss();
                      }
                    },
                    label: Text("كشف كلي"),
                    icon: Icon(Icons.picture_as_pdf),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(children: [
                  FutureBuilder(
                      future: Provider.of<ResellerController>(context,
                              listen: false)
                          .getResellerinfo(widget.resellerID.id.toString()),
                      // future: resellerProvider
                      //     .getResellerinfo(resellerID.id.toString()),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text(snapshot.error.toString());
                        } else if (snapshot.hasData) {
                          return TrapTableReseller(traps: snapshot.data!);
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      }),
                  // FutureBuilder(
                  //     future: Provider.of<ResellerController>(context,
                  //             listen: false)
                  //         .getDbetPayinfo(widget.resellerID.id.toString()),
                  //     builder: (context, snapshot) {
                  //       if (snapshot.hasError) {
                  //         return Text(snapshot.error.toString());
                  //       } else if (snapshot.hasData) {
                  //         return Card(
                  //           // height: double.maxFinite,
                  //           // width: double.infinity,
                  //           color: secondaryColor,
                  //           elevation: 5,
                  //           margin: EdgeInsets.all(defaultPadding),
                  //           child: DataTable(
                  //             columnSpacing: defaultPadding,
                  //             columns: [
                  //               DataColumn(
                  //                 label: Text("اسم الوكيل"),
                  //               ),
                  //               DataColumn(
                  //                 label: Text("رقم الوصل"),
                  //               ),
                  //               DataColumn(
                  //                 label: Text("المبلغ"),
                  //               ),
                  //               DataColumn(
                  //                 label: Text("سعر الصرف"),
                  //               ),
                  //               DataColumn(
                  //                 label: Text("التاريخ"),
                  //               ),
                  //             ],
                  //             rows: List.generate(
                  //                 snapshot.data!.length,
                  //                 (index) => DataRow(cells: [
                  //                       DataCell(
                  //                         Text(
                  //                           snapshot.data![index].resellerId
                  //                               .toString(),
                  //                         ),
                  //                       ),
                  //                       DataCell(
                  //                         Text(
                  //                           snapshot.data![index].id.toString(),
                  //                         ),
                  //                       ),
                  //                       DataCell(
                  //                         Text(
                  //                           snapshot.data![index].cost
                  //                               .toString(),
                  //                         ),
                  //                       ),
                  //                       DataCell(
                  //                         Text(
                  //                           snapshot.data![index].iqdToUsd
                  //                               .toString(),
                  //                         ),
                  //                       ),
                  //                       DataCell(
                  //                         Text(
                  //                           snapshot.data![index].createdAt
                  //                               .toString()
                  //                               .substring(0, 10),
                  //                         ),
                  //                       ),
                  //                     ])),
                  //           ),
                  //         );
                  //       } else {
                  //         return Center(child: CircularProgressIndicator());
                  //       }
                  //     })
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
