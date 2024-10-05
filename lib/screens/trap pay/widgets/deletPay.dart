import 'package:admin/controllers/trap_pay_controller.dart';
import 'package:admin/screens/widgets/deleteDialog.dart';
import 'package:admin/screens/widgets/snakbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<dynamic> deletPay(
    BuildContext context, AsyncSnapshot<List<dynamic>> snapshot, int index) {
  return deleteDialog(context, () async {
    try {
      await Provider.of<TrapPayController>(context, listen: false)
          .delete(snapshot.data![index].id, context);
      snackBar(context, "تم حذف التسديد بنجاح", false);
    } catch (e) {
      snackBar(context, e.toString(), true);
    }
  });
}
