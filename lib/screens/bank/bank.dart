import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/utl/constants.dart';
import 'package:flutter/material.dart';

class BankPage extends StatefulWidget {
  const BankPage({super.key});

  @override
  State<BankPage> createState() => _BankPageState();
}

class _BankPageState extends State<BankPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Header(title: "البنك"),
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                    color: Colors.white,
                    child: DataTable(
                      columns: [
                        DataColumn(
                          label: Text('الرقم'),
                        ),
                        DataColumn(
                          label: Text('اسم البنك'),
                        ),
                        DataColumn(
                          label: Text('النوع'),
                        ),
                        DataColumn(
                          label: Text('المبلغ'),
                        ),
                        DataColumn(
                          label: Text('التاريخ'),
                        ),
                      ],
                      rows: [],
                    )),
              ),
              SizedBox(
                width: defaultPadding,
              ),
              Expanded(
                flex: 1,
                child: Container(color: Colors.white, child: SizedBox()),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
