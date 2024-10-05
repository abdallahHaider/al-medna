import 'package:admin/responsive.dart';
import 'package:admin/utl/constants.dart';
import 'package:flutter/material.dart';

Padding globelIfo(
    AsyncSnapshot<Map<dynamic, dynamic>> snapshot, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
          color: blueColor,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      // color: secondaryColor,
      margin: EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: defaultPadding),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            // Row(
            //   children: [
            //     Expanded(
            //         child: Text(
            //       'معلومات عامة',
            //       textAlign: TextAlign.center,
            //     )),
            //     Expanded(flex: 1, child: SizedBox())
            //   ],
            // ),
            // SizedBox(
            //   height: defaultPadding,
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                          "التلكفة الاجمالية بالدولار : ${double.tryParse(snapshot.data!['total_cost_USD'].toString())!.toStringAsFixed(0)}"),
                      Divider(),
                      Text(
                          "المبلغ المدفوع بالدولار: ${double.tryParse(snapshot.data!['total_cost_USD_pays'].toString())!.toStringAsFixed(2)}"),
                      Divider(),
                      Text(
                          "المتبقي : ${double.tryParse((snapshot.data!['total_cost_USD'] - snapshot.data!['total_cost_USD_pays']).toString())!.toStringAsFixed(2)}"),
                    ]),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('عدد التسديدات :' +
                        snapshot.data!['count_pays'].toString()),
                    Divider(),
                    Text('عدد الرحلات :' +
                        snapshot.data!['count_trap'].toString()),
                    Divider(),
                    Text(
                        "المدة الزمنية : ${snapshot.data!['start_date'] == null ? "لا يوجد" : " من " + snapshot.data!['start_date'] + " الى " + snapshot.data!['end_date']}"),
                  ],
                ),
                if (Responsive.isDesktop(context)) SizedBox()
              ],
            ),
            SizedBox(
              height: defaultPadding,
            ),
          ],
        ),
      ),
    ),
  );
}
