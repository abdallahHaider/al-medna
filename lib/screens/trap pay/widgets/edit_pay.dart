import 'package:admin/controllers/trap_pay_controller.dart';
import 'package:admin/screens/widgets/my_text_field.dart';
import 'package:admin/screens/widgets/snakbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';

Future editPay(BuildContext context, int id) {
  var _editPayController = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  return showDialog(
      context: context,
      builder: (c) {
        return AlertDialog(
          title: Text("تعديل الفاتورة"),
          content: Form(
            key: _formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  MyTextField(
                    controller: _editPayController,
                    labelText: "المبلغ بالدولار",
                    validator: (value) {
                      //shod number inpot
                      if (value!.isEmpty ||
                          !RegExp(r'^\d+(\.\d{1,2})?$').hasMatch(
                              value.replaceAll(RegExp(r'[^\d\.]+'), ''))) {
                        return "الرجاء ادخال المبلغ";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ]),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  try {
                    SmartDialog.showLoading();
                    await Provider.of<TrapPayController>(context, listen: false)
                        .updatePay(
                            id.toString(), _editPayController.text.toString());
                    snackBar(context, "تم التعديل بنجاح", false);
                  } catch (e) {
                    print(e);
                    snackBar(context, e.toString(), true);
                  } finally {
                    SmartDialog.dismiss();
                    Navigator.pop(context);
                  }
                }
              },
              child: Text("حسناً"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("الغاء"),
            ),
          ],
        );
      });
}
