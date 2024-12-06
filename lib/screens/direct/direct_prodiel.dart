import 'package:admin/controllers/direct_controller.dart';
import 'package:admin/controllers/rootWidget.dart';
import 'package:admin/models/momter.dart';
import 'package:admin/models/momterPay.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/direct/direct_page.dart';
import 'package:admin/screens/edit_widget.dart';
import 'package:admin/screens/widgets/back_batten.dart';
import 'package:admin/screens/widgets/deleteDialog.dart';
import 'package:admin/screens/widgets/my_button.dart';
import 'package:admin/screens/widgets/my_data_table.dart';
import 'package:admin/screens/widgets/my_text_field.dart';
import 'package:admin/utl/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DirectProdiel extends StatefulWidget {
  const DirectProdiel({super.key, required this.id, required this.momter});
  final String id;
  final Momter momter;

  @override
  State<DirectProdiel> createState() => _DirectProdielState();
}

class _DirectProdielState extends State<DirectProdiel> {
  final _formKey = GlobalKey<FormState>();
  final cost = TextEditingController();
  final costEController = TextEditingController();
  bool isEdit = false;
  String EditId = "";

  @override
  void initState() {
    Provider.of<DirectController>(context, listen: false)
        .getDirectProfiel(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Header(title: "المباشر والاقساط - " + widget.momter.fullName!),
        actions: [
          BackBatten(
            onPressed: () {
              Provider.of<Rootwidget>(context, listen: false)
                  .getWidet(DirectPage());
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            cardMotamerDetels(widget.momter),
            Row(
              children: [
                Container(
                  width: 500,
                  padding: EdgeInsets.all(defaultPadding),
                  margin: EdgeInsets.all(defaultPadding),
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Header(
                          title: 'اضافة تسديد',
                        ),
                        SizedBox(height: defaultPadding),
                        MyTextField(
                          controller: cost,
                          labelText: 'مبلغ التسديد',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'برجاء ادخال اسم المبلغ';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: defaultPadding),
                        SizedBox(
                          width: double.infinity,
                          child: MyButton(
                              onPressed: () {
                                Provider.of<DirectController>(context,
                                        listen: false)
                                    .momterpay(context, widget.id, cost.text);
                              },
                              child: Text("اضافة تسديد")),
                        ),
                      ],
                    ),
                  ),
                ),
                if (isEdit)
                  SizedBox(
                    width: 500,
                    child: EditWidget(
                        savePressed: () async {
                          Provider.of<DirectController>(context, listen: false)
                              .payUpdete(context, widget.id,
                                  costEController.text, widget.id);
                        },
                        canselPressed: () {
                          cost.clear();
                          setState(() {
                            isEdit = false;
                          });
                        },
                        buildActions: [
                          MyTextField(
                            controller: costEController,
                            labelText: 'المبلغ',
                          )
                        ]),
                  ),
              ],
            ),
            Divider(),
            Consumer<DirectController>(builder: (context, con, Widget) {
              return SizedBox(
                  width: double.infinity,
                  child: MyDataTable(
                    columns: [
                      DataColumn(label: Text("الرقم")),
                      DataColumn(label: Text("الواصل")),
                      DataColumn(label: Text("التاريخ")),
                      DataColumn(label: Text("الاجراء")),
                    ],
                    rows: List.generate(con.momterPays.length, (index) {
                      MomterPay momterPay = con.momterPays[index];
                      return DataRow(
                          color: WidgetStatePropertyAll(Colors.white),
                          cells: [
                            DataCell(Text(momterPay.id!.toString())),
                            DataCell(Text(momterPay.cost.toString())),
                            DataCell(Text(momterPay.createdAt.toString())),
                            DataCell(Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isEdit = true;
                                        EditId = momterPay.id.toString();
                                        costEController.text =
                                            momterPay.cost.toString();
                                      });
                                    },
                                    icon: Icon(Icons.edit)),
                                IconButton(
                                    onPressed: () {
                                      deleteDialog(context, () {
                                        Provider.of<DirectController>(context,
                                                listen: false)
                                            .payDelete(
                                                context, widget.id, widget.id);
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

Widget cardMotamerDetels(Momter momter) {
  return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    10), // this will be the rounded corner
                color: blueColor),
            child: Table(children: [
              TableRow(children: [
                TableCell(
                  child: Text(
                    "اسم الرحلة",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ),
                TableCell(
                  child: Text(
                    "اسم المعتمر",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ),
                TableCell(
                  child: Text(
                    "رقم الهاتف",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ),
                TableCell(
                  child: Text(
                    "اجمالي المبلغ",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ),
              ]),
            ]),
          ),
          SizedBox(
            height: defaultPadding,
          ),
          Container(
            padding: EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    10), // this will be the rounded corner
                color: blueColor.withOpacity(0.3)),
            child: Table(children: [
              TableRow(children: [
                TableCell(
                  child: Text(
                    "${momter.trap!.nameOfTripe}",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ),
                TableCell(
                  child: Text(
                    "${momter.fullName}",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ),
                TableCell(
                  child: Text(
                    "${momter.phoneNumber}",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ),
                TableCell(
                  child: Text(
                    "${momter.totalCost}",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ),
              ]),
            ]),
          ),
          SizedBox(
            height: defaultPadding,
          ),
          Container(
            padding: EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    10), // this will be the rounded corner
                color: blueColor),
            child: Table(children: [
              TableRow(children: [
                TableCell(
                  child: Text(
                    "عدد القساط",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ),
                TableCell(
                  child: Text(
                    "مبلغ القسط",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ),
                TableCell(
                  child: Text(
                    "الايام المتبقية",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ),
                TableCell(
                  child: Text(
                    "الواصل",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ),
                TableCell(
                  child: Text(
                    "المتبقي",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ),
              ]),
            ]),
          ),
          SizedBox(
            height: defaultPadding,
          ),
          Container(
            padding: EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    10), // this will be the rounded corner
                color: blueColor.withOpacity(0.3)),
            child: Table(children: [
              TableRow(children: [
                TableCell(
                  child: Text(
                    "${momter.trap!.numberOfPushes}",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ),
                TableCell(
                  child: Text(
                    "${momter.trap!.cost}",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ),
                TableCell(
                  child: Text(
                    "${momter.date}",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ),
                TableCell(
                  child: Text(
                    "${momter.paid}",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ),
                TableCell(
                  child: Text(
                    "${momter.rest}",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ),
              ]),
            ]),
          ),
        ],
      ));
}
