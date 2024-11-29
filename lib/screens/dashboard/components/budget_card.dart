import 'package:admin/controllers/wallet_provider.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:admin/utl/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Row budgetCard() {
  return Row(
    children: [
      Card(
        color: blueColor,
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Header(title: "الصندوق الرئيسي"),
              SizedBox(
                height: defaultPadding,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(defaultPadding * 3),
                      child: Column(
                        children: [
                          Text(
                            'الرصيد بالدينار',
                            style: TextStyle(fontSize: 24, color: Colors.grey),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.money),
                              Consumer<WalletProvider>(
                                builder: (context, storage, child) {
                                  return Text(
                                    '${formatCustomNumber(storage.wallet_IQD).toString()}',
                                    style: TextStyle(
                                      fontSize: 24,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: defaultPadding,
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(defaultPadding * 3),
                      child: Column(
                        children: [
                          Text(
                            'الرصيد بالدولار',
                            style: TextStyle(fontSize: 24, color: Colors.grey),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.attach_money),
                              Consumer<WalletProvider>(
                                builder: (context, storage, child) {
                                  return Text(
                                    '${formatCustomNumber(storage.wallet_USD).toString()}',
                                    style: TextStyle(
                                      fontSize: 24,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
