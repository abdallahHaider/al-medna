import 'package:admin/controllers/rootWidget.dart';
import 'package:admin/controllers/trap_controller%20.dart';
import 'package:admin/screens/trap/add_trap.dart';
import 'package:admin/screens/trap/widget/dataBelder.dart';
import 'package:admin/screens/trap/widget/globelIfo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../dashboard/components/header.dart';
import 'package:admin/utl/constants.dart';
import 'package:admin/screens/widgets/erorr_widget.dart';

class TrapPage extends StatefulWidget {
  @override
  State<TrapPage> createState() => _TrapPageState();
}

class _TrapPageState extends State<TrapPage> {
  final duration = TextEditingController();

  final quantity = TextEditingController();

  final pricePerOne = TextEditingController();

  final rasToUsd = TextEditingController();

  final iqdToUsd = TextEditingController();

  final _startDateController = TextEditingController();

  final _endDateController = TextEditingController();

  String resslrid = "";

  String trapid = "";

  String transportsid = "";
  int page = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Header(title: 'الرحلات'),
                ),
                Expanded(
                  flex: 2,
                  child: Consumer<TrapController>(
                    builder: (context, value, _) {
                      return FutureBuilder(
                        future: value.fetchData(
                            _startDateController.text.isEmpty
                                ? ""
                                : "&start_date=${_startDateController.text}&end_date=${_endDateController.text}",
                            page),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return ErorrWidget();
                          } else if (snapshot.hasData) {
                            print(snapshot.data!);
                            return Column(
                              children: [
                                globelIfo(snapshot, context),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton.icon(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            WidgetStateProperty.all(
                                                primaryColor),
                                        foregroundColor:
                                            WidgetStateProperty.all(
                                                Colors.white),
                                      ),
                                      onPressed: () {
                                        Provider.of<Rootwidget>(context,
                                                listen: false)
                                            .getWidet(AddTrapPage());
                                      },
                                      label: Text("اضافة رحلة"),
                                      icon: Icon(Icons.add),
                                    ),
                                    Expanded(
                                      child: SizedBox(),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          if (page > 1) {
                                            page -= 1;
                                            Provider.of<TrapController>(context,
                                                    listen: false)
                                                .updete();
                                          }
                                        },
                                        child: Text("الصفحة السابقة")),
                                    Text("الصفحة :$page"),
                                    TextButton(
                                        onPressed: () {
                                          page += 1;
                                          Provider.of<TrapController>(context,
                                                  listen: false)
                                              .updete();
                                        },
                                        child: Text("الصفحة التالية")),
                                    Expanded(child: SizedBox()),
                                    TextButton.icon(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (c) => AlertDialog(
                                                  title: Text("حدد تاريخ"),
                                                  content: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      TextField(
                                                        controller:
                                                            _startDateController,
                                                        decoration:
                                                            InputDecoration(
                                                          labelText: "تاريخ من",
                                                          border:
                                                              OutlineInputBorder(),
                                                          filled: true,
                                                        ),
                                                        onTap: () async {
                                                          final DateTime?
                                                              picker =
                                                              await showDatePicker(
                                                            context: context,
                                                            initialDate:
                                                                DateTime.now(),
                                                            firstDate:
                                                                DateTime(2000),
                                                            lastDate: DateTime
                                                                    .now()
                                                                .add(Duration(
                                                                    days: 100)),
                                                          );
                                                          if (picker != null) {
                                                            // setState(() {
                                                            _startDateController
                                                                    .text =
                                                                picker
                                                                    .toString()
                                                                    .substring(
                                                                        0, 10);
                                                            // });
                                                          }
                                                        },
                                                      ),
                                                      TextField(
                                                        controller:
                                                            _endDateController,
                                                        decoration:
                                                            InputDecoration(
                                                          labelText:
                                                              "تاريخ الى",
                                                          border:
                                                              OutlineInputBorder(),
                                                          filled: true,
                                                        ),
                                                        onTap: () async {
                                                          final DateTime?
                                                              picker =
                                                              await showDatePicker(
                                                            context: context,
                                                            initialDate:
                                                                DateTime.now(),
                                                            firstDate:
                                                                DateTime(2000),
                                                            lastDate: DateTime
                                                                    .now()
                                                                .add(Duration(
                                                                    days: 100)),
                                                          );
                                                          if (picker != null) {
                                                            // setState(() {
                                                            _endDateController
                                                                    .text =
                                                                picker
                                                                    .toString()
                                                                    .substring(
                                                                        0, 10);
                                                            // });
                                                          }
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text("الغاء"),
                                                    ),
                                                    TextButton(
                                                      onPressed: () async {
                                                        if (_startDateController
                                                                .text.isEmpty ||
                                                            _endDateController
                                                                .text.isEmpty) {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                                content: Text(
                                                                    "من فضلك ادخل تاريخ من و الى")),
                                                          );
                                                        } else {
                                                          page = 1;
                                                          Provider.of<TrapController>(
                                                                  context,
                                                                  listen: false)
                                                              .updete();
                                                          Navigator.of(context)
                                                              .pop();
                                                        }
                                                      },
                                                      child: Text("حسنا"),
                                                    ),
                                                  ],
                                                ));
                                      },
                                      label: Text("بحث متقدم"),
                                      icon: Icon(Icons.search),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: defaultPadding,
                                ),
                                // dataBelder(snapshot,context),

                                TrapTable(
                                  traps: snapshot.data!["resellers"],
                                )
                              ],
                            );
                          } else {
                            return Center(child: Text('لا توجد بيانات'));
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
