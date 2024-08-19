import 'package:admin/controllers/wallet_provider.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/utl/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => WalletProvider(),
      child: Scaffold(
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Header(title: "الخزنة"),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Card(
                  child: DataTable(
                    columns: [
                      DataColumn(label: Text('الرصيد')),
                      DataColumn(label: Text('العمليات')),
                    ],
                    rows: [],
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Column(
                      children: [
                        Header(title: "اضافة عملية"),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'الرصيد',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'ملاحضة',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text('اضافة'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
