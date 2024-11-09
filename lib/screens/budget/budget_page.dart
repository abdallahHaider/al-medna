import 'package:admin/controllers/budget_controller.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BudgetPage extends StatefulWidget {
  const BudgetPage({super.key});

  @override
  State<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  @override
  void initState() {
    Provider.of<BudgetController>(context, listen: false).getBuget();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Header(title: "الميزانية"),
              const SizedBox(height: 20),
              Consumer<BudgetController>(builder: (context, watch, child) {
                if (watch.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: buildCapitalContainer("رأس المال بل دولار",
                              context, "usd", "additional"),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: buildCapitalContainer("رأس المال بل دينار",
                              context, "iqd", "additional_iqd"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: buildTableContainer(
                                context,
                                " جدول الميزانية بل دولار",
                                "additional",
                                names_usd),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: buildTableContainer(
                                context,
                                " جدول الميزانية بل دينار",
                                "additional_iqd",
                                names_iqd),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCapitalContainer(
      String title, BuildContext context, String currency, String path) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [Colors.blue.shade200, Colors.blue.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "الطالب",
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 100,
                      child: Consumer<BudgetController>(
                          builder: (context, watch, child) {
                        List x = watch.budget[path] as List;
                        return Text(
                          path == "additional"
                              ? (x[0]["traps"] +
                                      x[1]["softDoc_usd"] +
                                      x[2]["company"])
                                  .toStringAsFixed(2)
                              : (x[0]["softDoc_iqd"] +
                                      x[1]["small_bank_iqd"] +
                                      x[2]["bank_iqd"])
                                  .toStringAsFixed(2),
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }),
                    ),
                  ],
                ),
                /////
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "مطلوب",
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 100,
                      child: Consumer<BudgetController>(
                          builder: (context, watch, child) {
                        List x = watch.budget[path] as List;
                        return Text(
                          path == "additional"
                              ? (x[3]["small_bank"] + x[4]["bank"])
                                  .toStringAsFixed(2)
                              : (x[3]["authority_iqd"]).toStringAsFixed(2),
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }),
                    ),
                  ],
                ),
                ////
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Consumer<BudgetController>(
                        builder: (context, watch, child) {
                      double currencyValue = (watch.budget[currency] is int)
                          ? (watch.budget[currency] as int).toDouble()
                          : watch.budget[currency] ?? 0.0;
                      List x = watch.budget["additional"] as List;
                      return Text(
                        // ناقص حساب الفنادق
                        (currencyValue -
                                (path == "additional" ? x.last["hotel"] : 0))
                            .toStringAsFixed(2),
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }),
                  ],
                ),

                ///
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTableContainer(BuildContext context, String tableName,
      String additionalKey, List<String> names) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tableName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 10),
            Consumer<BudgetController>(builder: (context, watch, child) {
              List<Map<String, dynamic>> additionalData =
                  (watch.budget[additionalKey] as List)
                      .map((item) => Map<String, dynamic>.from(item))
                      .toList();

              List<DataRow> talebRows = [];
              List<DataRow> matloubRows = [];

              for (int index = 0; index < additionalData.length; index++) {
                String key = additionalData[index].keys.first;
                dynamic value = additionalData[index][key];
                double amount = (value is int) ? value.toDouble() : value;

                DataRow row = DataRow(cells: [
                  DataCell(Text((index + 1).toString())),
                  DataCell(Text(names[index])),
                  DataCell(Text(amount <= 0 ? "مطلوب" : "طالب")),
                  DataCell(Text(amount.abs().toStringAsFixed(2))),
                ]);

                if (amount <= 0) {
                  matloubRows.add(row);
                } else {
                  talebRows.add(row);
                }
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // جدول "طالب"
                  Column(
                    children: [
                      Text(
                        "الطالب",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      DataTable(
                        columnSpacing: 20.0,
                        headingTextStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                        columns: const [
                          DataColumn(label: Text('ت')),
                          DataColumn(label: Text('الاسم')),
                          DataColumn(label: Text('النوع')),
                          DataColumn(label: Text('المبلغ')),
                        ],
                        rows: talebRows,
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  // جدول "مطلوب"
                  Column(
                    children: [
                      Text(
                        "المطلوب",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      DataTable(
                        columnSpacing: 20.0,
                        headingTextStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                        columns: const [
                          DataColumn(label: Text('ت')),
                          DataColumn(label: Text('الاسم')),
                          DataColumn(label: Text('النوع')),
                          DataColumn(label: Text('المبلغ')),
                        ],
                        rows: matloubRows,
                      ),
                    ],
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}

List<String> names_usd = [
  'الرحلات',
  'الخزنه',
  'شركات السعودي',
  'المنافذ',
  'البنوك',
  "الفنادق",
];

List<String> names_iqd = [
  'الخزنه',
  'المنافذ',
  'البنوك',
  "الهيئات",
];
