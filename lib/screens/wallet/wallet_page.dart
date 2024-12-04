import 'package:flutter/material.dart';
import 'package:admin/controllers/rootWidget.dart';
import 'package:admin/controllers/wallet_provider.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/wallet/widgets/wallet_action.dart';
import 'package:admin/screens/wallet/widgets/wallet_table.dart';
import 'package:admin/screens/widgets/erorr_widget.dart';
import 'package:admin/utl/constants.dart';
import 'package:provider/provider.dart';
import 'package:admin/pdf/reseller_Pdf walt.dart';
import 'package:intl/intl.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  @override
  void initState() {
    Provider.of<WalletProvider>(context, listen: false).getWallet(false);
    super.initState();
  }

  // دالة لتنسيق الرقم بإضافة الفواصل
  String formatCustomNumber(String value) {
    if (value.isEmpty) return '';
    final number = double.tryParse(value.replaceAll(',', ''));
    if (number == null) return value;
    return NumberFormat('#,##0')
        .format(number); // يستخدم هذا التنسيق الفاصلة بين الألوف
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Header(title: "الصندوق الرئيسي"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              elevation: 5,
              color: blueColor,
              margin: EdgeInsets.all(defaultPadding),
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: Consumer<WalletProvider>(
                  builder: (context, walletProvider, child) {
                    return IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildBalanceCard(
                              "الرصيد الحالي في الصندوق الرئيسي بالدينار",
                              "${formatCustomNumber(walletProvider.wallet_IQD.toString())} دينار"),
                          VerticalDivider(),
                          _buildBalanceCard(
                              "الرصيد الحالي في الصندوق الرئيسي بالدولار",
                              "${formatCustomNumber(walletProvider.wallet_USD.toString())} دولار"),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(defaultPadding),
                          child: Row(
                            children: [
                              _buildActionButton("اضافة عملية", () {
                                Provider.of<Rootwidget>(context, listen: false)
                                    .getWidet(WalletAction(
                                  isAdd: true,
                                ));
                              }, primaryColor),
                              SizedBox(width: 10),
                              _buildActionButton("طباعة كشف الحساب", () {
                                final walletProvider =
                                    Provider.of<WalletProvider>(context,
                                        listen: false);
                                // استدعاء دالة الطباعة
                                ResellerToPdfWalt(
                                  walletProvider.wallets, // البيانات للطباعة
                                  walletProvider.wallet_IQD.toString(),
                                  walletProvider.wallet_USD.toString(),
                                );
                              }, primaryColor),
                              Spacer(),
                              _buildPageNavigationButton("الصفحة السابقة", () {
                                Provider.of<WalletProvider>(context,
                                        listen: false)
                                    .getPage(-1, false);
                              }),
                              Consumer<WalletProvider>(
                                builder: (context, walletProvider, child) {
                                  return Text(
                                      "الصفحة : ${walletProvider.page}");
                                },
                              ),
                              _buildPageNavigationButton("الصفحة التالية", () {
                                Provider.of<WalletProvider>(context,
                                        listen: false)
                                    .getPage(1, false);
                              }),
                              Spacer(),
                            ],
                          ),
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

  Widget _buildBalanceCard(String title, String amount) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 90),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(title, style: TextStyle(fontSize: 16)),
            Text(amount, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String text, VoidCallback onPressed, Color color) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(color),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        foregroundColor: WidgetStateProperty.all(Colors.white),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }

  Widget _buildPageNavigationButton(String text, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
