import 'package:admin/controllers/wallet_provider.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/wallet/widgets/wallet_action.dart';
import 'package:admin/screens/wallet/widgets/wallet_table.dart';
import 'package:admin/screens/widgets/erorr_widget.dart';
import 'package:admin/utl/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  @override
  void initState() {
    // Provider.of<WalletProvider>(context, listen: false).getWallet();
    super.initState();
  }

  @override
  void dispose() {
    Provider.of<WalletProvider>(context, listen: false).dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Header(title: "الخزنة"),
        ),
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Consumer(builder: (context, walletProvider, child) {
                        return SizedBox(
                          width: double.maxFinite,
                          child: Card(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(defaultPadding),
                              child: Column(
                                children: [
                                  Text(
                                    "الرصيد الحالي في الخزنة",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    "${"00"}",
                                    style: TextStyle(fontSize: 24),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                      SizedBox(
                        height: defaultPadding,
                      ),
                      Consumer<WalletProvider>(
                        builder: (context, controller, child) {
                          if (controller.isLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (controller.isError) {
                            return Center(child: MyErrorWidget());
                          } else {
                            return walletTable(controller);
                          }
                        },
                      ),
                    ],
                  )),
              SizedBox(
                width: defaultPadding,
              ),
              Expanded(
                child: WalletAction(),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
