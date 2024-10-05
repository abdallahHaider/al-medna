import 'package:admin/controllers/action_bank_controller.dart';
import 'package:admin/controllers/wallet_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utl/constants.dart';

class StorageDetails extends StatelessWidget {
  const StorageDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: secondaryColor,
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.account_balance,
              size: 100,
            ),
            Text(
              'الصندوق الرئيسي',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(
              height: defaultPadding,
            ),

            SizedBox(
              height: defaultPadding,
            ),
            Text(
              'الرصيد بالدولار',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.attach_money),
                Consumer<WalletProvider>(
                  builder: (context, storage, child) {
                    return Text(
                      '${storage.wallet_USD}',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    );
                  },
                ),
              ],
            ),
            //المصرف/////////////////////////////////////////////////////////////////////
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.account_balance,
                    size: 100,
                  ),
                  Text(
                    'المصرف',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  SizedBox(
                    height: defaultPadding,
                  ),

                  Text(
                    'الرصيد بالدينار',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.money),
                      Consumer<WalletProvider>(
                        builder: (context, storage, child) {
                          return Text(
                            '${storage.wallet_IQD}',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  Text(
                    'الرصيد بالدولار',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.attach_money),
                      Consumer<WalletProvider>(
                        builder: (context, storage, child) {
                          return Text(
                            '${storage.wallet_USD}',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  // البنك////////////////////////////////////////////////////////////
                  Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.account_balance,
                          size: 100,
                        ),
                        Text(
                          'البنك',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                        SizedBox(
                          height: defaultPadding,
                        ),
                        Text(
                          'الرصيد بالدينار',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.money),
                            Consumer<ActionBankController>(
                              builder: (context, storage, child) {
                                return Text(
                                  '${storage.isTo}',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: defaultPadding,
                        ),
                        Text(
                          'الرصيد بالدولار',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.attach_money),
                            Consumer<WalletProvider>(
                              builder: (context, storage, child) {
                                return Text(
                                  '${storage.wallet_USD}',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
