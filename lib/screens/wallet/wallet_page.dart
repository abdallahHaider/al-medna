import 'package:admin/controllers/rootWidget.dart';
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
    Provider.of<WalletProvider>(context, listen: false).getWallet();
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
                      Padding(
                        padding: const EdgeInsets.all(defaultPadding),
                        child: Row(
                          children: [
                            ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.all(primaryColor),
                                  shape: WidgetStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  foregroundColor:
                                      WidgetStateProperty.all(Colors.white),
                                ),
                                onPressed: () {
                                  Provider.of<Rootwidget>(context,
                                          listen: false)
                                      .getWidet(WalletAction());
                                },
                                child: Text("اضافة عملية")),
                            Expanded(
                              child: SizedBox(),
                            ),
                            TextButton(
                                onPressed: () {
                                  Provider.of<WalletProvider>(context,
                                          listen: false)
                                      .getPage(-1);
                                },
                                child: Text("الصفحة السابقة")),
                            Text("الصفحة :"),
                            TextButton(
                                onPressed: () {
                                  Provider.of<WalletProvider>(context,
                                          listen: false)
                                      .getPage(1);
                                },
                                child: Text("الصفحة التالية")),
                            Expanded(child: SizedBox()),
                          ],
                        ),
                      ),
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
                            return walletTable(controller, context);
                          }
                        },
                      ),
                    ],
                  )),
              SizedBox(
                width: defaultPadding,
              ),
              Expanded(
                // child: WalletAction(),
                child: Card(
                  elevation: 5,
                  color: secondaryColor,
                  child: SizedBox(
                    height: 500,
                    child: Consumer<WalletProvider>(
                        builder: (context, walletProvider, child) {
                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "الرصيد الحالي في الخزنة بالدينار",
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  "${walletProvider.wallet_IQD} دينار",
                                  style: TextStyle(fontSize: 24),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "الرصيد الحالي في الخزنة بالدولار",
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  "${walletProvider.wallet_USD} دولار",
                                  style: TextStyle(fontSize: 24),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
