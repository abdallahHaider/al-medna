import 'package:admin/controllers/trap_pay_controller.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/widgets/snakbar.dart';
import 'package:admin/utl/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<dynamic> deletPay(
    BuildContext context, AsyncSnapshot<List<dynamic>> snapshot, int index) {
  return showDialog(
      context: context,
      builder: (c) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: Column(
            children: [
              SizedBox(
                height: defaultPadding * 5,
              ),
              Card(
                  child: Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Header(
                              title: 'حذف التسديد ',
                            ),
                            SizedBox(height: defaultPadding),
                            Text("هل انت متاكد من انك تريد حذف التسديد"),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    try {
                                      await Provider.of<TrapPayController>(
                                              context,
                                              listen: false)
                                          .delete(snapshot.data![index].id,
                                              context);
                                      snackBar(context, "تم حذف التسديد بنجاح",
                                          false);
                                    } catch (e) {
                                      snackBar(context, e.toString(), true);
                                    }
                                  },
                                  child: Text('حذف'),
                                ),
                                InkWell(
                                  child: Text(
                                    "الغاء",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            ),
                          ]))),
            ],
          ),
        );
      });
}
