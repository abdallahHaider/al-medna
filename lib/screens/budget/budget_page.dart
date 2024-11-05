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
                          child: buildCapitalContainer(
                              "رأس المال بل دولار", context, "usd"),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: buildCapitalContainer(
                              "رأس المال بل دينار", context, "iqd"),
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
      String title, BuildContext context, String currency) {
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
            Consumer<BudgetController>(builder: (context, watch, child) {
              double currencyValue = (watch.budget[currency] is int)
                  ? (watch.budget[currency] as int).toDouble()
                  : watch.budget[currency] ?? 0.0;
              List x = watch.budget["additional"] as List;
              return Text(
                // ناقص حساب الفنادق
                (currencyValue - x.last["hotel"]).toStringAsFixed(2),
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget buildTableContainer(BuildContext context, String tableName,
      String additionalKey, List<String> names) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
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

              return DataTable(
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
                rows: List.generate(
                  // عرض الفنادق في الجدول
                  additionalData.length - 1,
                  (index) {
                    String key = additionalData[index].keys.first;
                    dynamic value = additionalData[index][key];

                    double amount = (value is int) ? value.toDouble() : value;

                    return DataRow(cells: [
                      DataCell(Text((index + 1).toString())),
                      DataCell(Text(names[index])),
                      DataCell(Text(amount <= 0 ? "مطلوب" : "طالب")),
                      DataCell(Text(amount.abs().toStringAsFixed(2))),
                    ]);
                  },
                ),
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
