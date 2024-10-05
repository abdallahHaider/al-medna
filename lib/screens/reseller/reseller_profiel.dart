import 'package:admin/controllers/reseller_controller.dart';
import 'package:admin/controllers/rootWidget.dart';
import 'package:admin/models/reseller.dart';
import 'package:admin/models/reseller_dbet.dart';
import 'package:admin/pdf/reseller_Pdf.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/reseller/reseller_page.dart';
import 'package:admin/screens/reseller/widgets/cardResellerDetels.dart';
import 'package:admin/screens/reseller/widgets/trap_tibel.dart';
import 'package:admin/screens/widgets/back_batten.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Header(title: "تفاصيل الوكيل"),
        actions: [
          BackBatten(
            onPressed: () {
              Provider.of<Rootwidget>(context, listen: false)
                  .getWidet(ResellerPage());
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            cardResellerDetels(widget.resellerID),
            Divider(),
            Row(
              children: [
                Expanded(child: Header(title: "الرحلات")
                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [Tab(text: "الرحلات"), Divider()],
                    // ),
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
                      await ResellerToPdf(widget.resellerID, globlDebt, traps);
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
            FutureBuilder(
                future: Provider.of<ResellerController>(context, listen: false)
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
          ],
        ),
      ),
    );
  }
}
