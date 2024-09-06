import 'package:admin/controllers/budget_controller.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/utl/constants.dart';
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
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Header(title: "الميزانية"),
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(100),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  const Text(
                    "الاحمالي بالدولار",
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Consumer<BudgetController>(
                      builder: (context, watch, child) => Text(
                            "${watch.budget["usd"].toString()}",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          )),
                  const SizedBox(height: 10),
                ]),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(100),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  const Text(
                    "الاحمالي بالدينار",
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Consumer<BudgetController>(
                      builder: (context, watch, child) => Text(
                            "${watch.budget["iqd"].toString()}",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          )),
                  const SizedBox(height: 10),
                ]),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
