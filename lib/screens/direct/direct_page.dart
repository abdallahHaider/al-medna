import 'package:admin/controllers/direct_controller.dart';
import 'package:admin/controllers/rootWidget.dart';
import 'package:admin/models/format_price.dart';
import 'package:admin/models/momter.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/direct/add_direct_page.dart';
import 'package:admin/screens/direct/direct_prodiel.dart';
import 'package:admin/screens/widgets/deleteDialog.dart';
import 'package:admin/screens/widgets/my_button.dart';
import 'package:admin/screens/widgets/my_data_table.dart';
import 'package:admin/utl/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spelling_number/spelling_number.dart';

class DirectPage extends StatefulWidget {
  const DirectPage({super.key});

  @override
  State<DirectPage> createState() => _DirectPageState();
}

class _DirectPageState extends State<DirectPage> {
  @override
  void initState() {
    Provider.of<DirectController>(context, listen: false).getDirect(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Header(title: "المباشر والاقساط"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyButton(
                    onPressed: () {
                      Provider.of<Rootwidget>(context, listen: false)
                          .getWidet(AddDirectPage());
                    },
                    child: Text("اضافة جديد")),
                Consumer<DirectController>(builder: (context, con, Widget) {
                  return MyButton(
                      onPressed: () {
                        if (con.is_archive) {
                          con.setArchive(false);
                        } else {
                          con.setArchive(true);
                        }
                      },
                      child: Text(con.is_archive ? "العام" : "الارشيف"));
                }),
              ],
            ),
            Consumer<DirectController>(builder: (context, con, Widget) {
              return SizedBox(
                  width: double.infinity,
                  child: MyDataTable(
                    columns: [
                      DataColumn(label: Text("اسم الرحلة")),
                      DataColumn(label: Text("اسم المعتمر")),
                      DataColumn(label: Text("رقم الهاتف")),
                      DataColumn(label: Text("الاجمالي")),
                      DataColumn(label: Text("عدد الاقساط")),
                      DataColumn(label: Text("مبلغ القسط")),
                      DataColumn(label: Text("الايام المتبقية")),
                      DataColumn(label: Text("الواصل")),
                      DataColumn(label: Text("الاباقي")),
                      DataColumn(label: Text("الاجراء")),
                    ],
                    rows: List.generate(con.momters.length, (index) {
                      Momter momter = con.momters[index];
                      return DataRow(
                          color: momter.trap!.numberOfPushes > 0
                              ? WidgetStatePropertyAll(Colors.white)
                              : WidgetStatePropertyAll(Colors.green.shade100),
                          cells: [
                            DataCell(
                                Text(con.momters[index].trap!.nameOfTripe
                                    .toString()), onTap: () {
                              if (momter.trap!.numberOfPushes > 0) {
                                Provider.of<Rootwidget>(context, listen: false)
                                    .getWidet(DirectProdiel(
                                  id: momter.trap!.id.toString(),
                                  momter: momter,
                                ));
                              }
                            }),
                            DataCell(
                              Text(con.momters[index].fullName.toString()),
                              onTap: () {
                                if (momter.trap!.numberOfPushes > 0) {
                                  Provider.of<Rootwidget>(context,
                                          listen: false)
                                      .getWidet(DirectProdiel(
                                    id: momter.trap!.id.toString(),
                                    momter: momter,
                                  ));
                                }
                              },
                            ),
                            DataCell(
                              Text(con.momters[index].phoneNumber.toString()),
                              onTap: () {
                                if (momter.trap!.numberOfPushes > 0) {
                                  Provider.of<Rootwidget>(context,
                                          listen: false)
                                      .getWidet(DirectProdiel(
                                    id: momter.trap!.id.toString(),
                                    momter: momter,
                                  ));
                                }
                              },
                            ),
                            DataCell(
                              Text(con.momters[index].totalCost.toString()),
                              onTap: () {
                                if (momter.trap!.numberOfPushes > 0) {
                                  Provider.of<Rootwidget>(context,
                                          listen: false)
                                      .getWidet(DirectProdiel(
                                    id: momter.trap!.id.toString(),
                                    momter: momter,
                                  ));
                                }
                              },
                            ),
                            DataCell(
                                Text(con.momters[index].trap!.numberOfPushes
                                    .toString()), onTap: () {
                              if (momter.trap!.numberOfPushes > 0) {
                                Provider.of<Rootwidget>(context, listen: false)
                                    .getWidet(DirectProdiel(
                                  id: momter.trap!.id.toString(),
                                  momter: momter,
                                ));
                              }
                            }),
                            DataCell(
                              Text(formatPrice(double.tryParse(
                                      con.momters[index].totalCost ?? "0")! /
                                  (con.momters[index].trap!.numberOfPushes ??
                                      "0"))),
                              onTap: () {
                                if (momter.trap!.numberOfPushes > 0) {
                                  Provider.of<Rootwidget>(context,
                                          listen: false)
                                      .getWidet(DirectProdiel(
                                    id: momter.trap!.id.toString(),
                                    momter: momter,
                                  ));
                                }
                              },
                            ),
                            DataCell(
                              Text(translateTime(con.momters[index].date)),
                              onTap: () {
                                if (momter.trap!.numberOfPushes > 0) {
                                  Provider.of<Rootwidget>(context,
                                          listen: false)
                                      .getWidet(DirectProdiel(
                                    id: momter.trap!.id.toString(),
                                    momter: momter,
                                  ));
                                }
                              },
                            ),
                            DataCell(
                              Text(con.momters[index].paid.toString()),
                              onTap: () {
                                if (momter.trap!.numberOfPushes > 0) {
                                  Provider.of<Rootwidget>(context,
                                          listen: false)
                                      .getWidet(DirectProdiel(
                                    id: momter.trap!.id.toString(),
                                    momter: momter,
                                  ));
                                }
                              },
                            ),
                            DataCell(
                              Text(con.momters[index].rest.toString()),
                              onTap: () {
                                if (momter.trap!.numberOfPushes > 0) {
                                  Provider.of<Rootwidget>(context,
                                          listen: false)
                                      .getWidet(DirectProdiel(
                                    id: momter.trap!.id.toString(),
                                    momter: momter,
                                  ));
                                }
                              },
                            ),
                            DataCell(Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      if (con.is_archive) {
                                        Provider.of<DirectController>(context,
                                                listen: false)
                                            .archive(
                                                context,
                                                con.momters[index].id
                                                    .toString(),
                                                0);
                                      } else {
                                        Provider.of<DirectController>(context,
                                                listen: false)
                                            .archive(
                                                context,
                                                con.momters[index].id
                                                    .toString(),
                                                1);
                                      }
                                    },
                                    icon: Icon(Icons.archive)),
                                IconButton(
                                    onPressed: () {
                                      deleteDialog(context, () {
                                        Provider.of<DirectController>(context,
                                                listen: false)
                                            .momterDelete(
                                                context, con.momters[index].id);
                                      });
                                    },
                                    icon: Icon(Icons.delete)),
                              ],
                            ))
                          ]);
                    }),
                  ));
            })
          ],
        ),
      ),
    );
  }
}

String translateTime(String input) {
  // تعريف القاموس الذي يحتوي على الكلمات الإنجليزية وما يقابلها بالعربية
  final Map<String, String> translationMap = {
    "days": "ايام",
    "day": "يوم",
    "months": "اشهر",
    "month": "شهر",
    "years": "سنين",
    "year": "سنة",
    "hours": "ساعات",
    "hour": "ساعة",
    "minutes": "دقائق",
    "minute": "دقيقة",
    "seconds": "ثواني",
    "second": "ثانية",
    "after": "بعد",
    "before": "قبل",
    "and": "و"
  };

  // استبدال ]الكلمات باستخدام القاموس
  translationMap.forEach((key, value) {
    input = input.replaceAll(key, value);
  });

  var x = input.split(" ").reversed;

  var y = x.where(
    (element) {
      return int.tryParse(element) != null;
    },
  );
  var r = x.join(" ");
  y.forEach((element) {
    r = r.replaceAll(
        element, SpellingNumber(lang: 'ar').convert(int.parse(element)));
  });
  return r;

  // return input.split(" ").reversed.join(" ");
}
