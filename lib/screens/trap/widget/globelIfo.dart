import 'package:admin/responsive.dart';
import 'package:admin/utl/constants.dart';
import 'package:flutter/material.dart';

Padding globelIfo(
    AsyncSnapshot<Map<dynamic, dynamic>> snapshot, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Card(
      color: secondaryColor,
      margin: EdgeInsets.symmetric(horizontal: defaultPadding),
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: defaultPadding),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                    child: Text(
                  'معلومات عامة',
                  textAlign: TextAlign.center,
                )),
                Expanded(flex: 1, child: SizedBox())
              ],
            ),
            SizedBox(
              height: defaultPadding,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                          "التلكفة الاجمالية بالدولار : ${snapshot.data!['total_cost_USD'].toString()}"),
                      Divider(),
                      Text(
                          "المبلغ المدفوع بالدولار: ${snapshot.data!['total_cost_USD_pays'].toString()}"),
                      Divider(),
                      Text(
                          "المتبقي : ${snapshot.data!['total_cost_USD'] - snapshot.data!['total_cost_USD_pays']}"),
                      // Text(
                      //   "الارباح بالدينار: ${(snapshot.data!['total_cost_IQD_pays'] - snapshot.data!['total_cost_IQD']).toString()}",
                      //   style: TextStyle(
                      //       color: snapshot.data!['total_cost_IQD_pays'] -
                      //                   snapshot.data!['total_cost_IQD'] <
                      //               0
                      //           ? Colors.red
                      //           : Colors.green),
                      // ),
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
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 12.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text(
            //           "التلكفة الاجمالية بالدولار : ${snapshot.data!['total_cost_USD'].toString()}"),
            //       // Text(
            //       //     "التلكفة الاجمالية بالدينار : ${snapshot.data!['total_cost_IQD'].toString()}"),
            //       // Text(
            //       //     "التلكفة الاجمالية بالريل السعودي : ${snapshot.data!['total_cost_RAS'].toString()}"),
            //     ],
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 12),
            //   child: Divider(),
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 12.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text(
            //           "المبلغ المدفوع بالدولار: ${snapshot.data!['total_cost_USD_pays'].toString()}"),
            //       // Text(
            //       //     "المبلغ المدفوع بالدينار: ${snapshot.data!['total_cost_IQD_pays'].toString()}"),
            //       // Text(
            //       //     "المبلغ المدفوع بالريل السعودي: ${snapshot.data!['total_cost_RAS_pays'].toString()}"),
            //     ],
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 12),
            //   child: Divider(),
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 12.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text(
            //         "الارباح بالدينار: ${(snapshot.data!['total_cost_IQD_pays'] - snapshot.data!['total_cost_IQD']).toString()}",
            //         style: TextStyle(
            //             color: snapshot.data!['total_cost_IQD_pays'] -
            //                         snapshot.data!['total_cost_IQD'] <
            //                     0
            //                 ? Colors.red
            //                 : Colors.green),
            //       ),
            //       // Text(
            //       //   "الارباح بالريال: ${(snapshot.data!['total_cost_RAS_pays'] - snapshot.data!['total_cost_RAS']).toString()}",
            //       //   style: TextStyle(
            //       //       color: snapshot.data!['total_cost_RAS_pays'] -
            //       //                   snapshot.data!['total_cost_RAS'] <
            //       //               0
            //       //           ? Colors.red
            //       //           : Colors.green),
            //       // ),
            //     ],
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 12),
            //   child: Divider(),
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 12),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text('عدد التسديدات :' +
            //           snapshot.data!['count_pays'].toString()),
            //       Text(
            //           "المدة الزمنية : ${snapshot.data!['start_date'] == null ? "لا يوجد" : " من " + snapshot.data!['start_date'] + " الى " + snapshot.data!['end_date']}"),
            //       Text('عدد الرحلات :' + snapshot.data!['count_trap'].toString()),
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   height: 10,
            // )
          ],
        ),
      ),
    ),
  );
}
