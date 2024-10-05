import 'package:admin/controllers/reseller_controller.dart';
import 'package:admin/controllers/trap_pay_controller.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/widgets/my_text_field.dart';
import 'package:admin/screens/widgets/snakbar.dart';
import 'package:admin/utl/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget addPay(BuildContext context) {
  String resslrid = "";
  final costUSDController = TextEditingController();
  final costIQDController = TextEditingController();
  // final namberController = TextEditingController();
  final uSDController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Form(
        key: _formkey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Header(
                title: 'اضافة تسديد',
              ),
              SizedBox(height: defaultPadding),
              Row(
                children: [
                  SizedBox(
                    width: 500,
                    child: Consumer<ResellerController>(
                      builder: (BuildContext context, value, Widget? child) {
                        return DropdownButtonFormField<dynamic>(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: "الوكيل",
                            fillColor:
                                Theme.of(context).scaffoldBackgroundColor,
                          ),
                          onChanged: (dynamic value) {
                            resslrid = value.id.toString();
                          },
                          items: value.resellerss.map((dynamic companies) {
                            return DropdownMenuItem<dynamic>(
                              value: companies,
                              child: Text(companies.fullName!),
                            );
                          }).toList(),
                          validator: (value) =>
                              value == null ? 'يرجى ادخال الوكيل' : null,
                        );
                      },
                    ),
                  ),
                  SizedBox(width: defaultPadding),
                  SizedBox(
                    width: 500,
                    child: MyTextField(
                      labelText: "المبلغ بالدولار",
                      controller: costUSDController,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'الرجاء ادخال سعر المبلغ';
                        }
                        final x = double.tryParse(value);
                        if (x == null) {
                          return 'الرجاء ادخال المبلغ صالح';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: defaultPadding),
              Row(
                children: [
                  SizedBox(
                    width: 500,
                    child: MyTextField(
                      labelText: "المبلغ بالدينار",
                      controller: costIQDController,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value!.isNotEmpty) {
                          final x = double.tryParse(value);
                          if (x == null) {
                            return 'الرجاء ادخال المبلغ صالح';
                          }
                          return null;
                        }

                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    width: defaultPadding,
                  ),
                  SizedBox(
                    width: 500,
                    child: MyTextField(
                      controller: uSDController,
                      labelText: "سعر الصرف",
                      validator: (value) {
                        if (costIQDController.text.isNotEmpty) {
                          if (value!.isEmpty) {
                            return 'الرجاء ادخال سعر الصرف';
                          }
                          final x = double.tryParse(value);
                          if (x == null) {
                            return 'الرجاء ادخال سعر الصرف صحيح';
                          }
                          return null;
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: defaultPadding),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if (_formkey.currentState!.validate()) {
                        try {
                          await Provider.of<TrapPayController>(context,
                                  listen: false)
                              .addReseller(
                                  costUSDController.text,
                                  costIQDController.text,
                                  uSDController.text,
                                  resslrid,
                                  context);
                        } catch (e) {
                          snackBar(context, e.toString(), true);
                          print(e);
                        }
                      }
                    },
                    child: Text('اضافة'),
                  ),
                ],
              ),
            ]),
      ));
}
