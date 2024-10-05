import 'package:admin/controllers/wallet_provider.dart';
import 'package:admin/screens/edit_widget.dart';
import 'package:admin/screens/many%20send/many_taybl.dart';
import 'package:admin/screens/many%20send/widgets/add_pay.dart';
import 'package:admin/screens/widgets/erorr_widget.dart';
import 'package:admin/screens/widgets/my_text_field.dart';
import 'package:admin/utl/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManySendPage extends StatefulWidget {
  const ManySendPage({super.key});

  @override
  State<ManySendPage> createState() => _ManySendPageState();
}

class _ManySendPageState extends State<ManySendPage> {
  bool isEdit = false; // default is false
  final name = TextEditingController();
  final cost_IRQ = TextEditingController();
  final cost_USD = TextEditingController();
  final note = TextEditingController();

  @override
  void initState() {
    Provider.of<WalletProvider>(context, listen: false).getWallet(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (!isEdit) AddPay(),
                  if (isEdit)
                    SizedBox(
                      width: 500,
                      child: EditWidget(
                          savePressed: () {},
                          canselPressed: () {
                            setState(() {
                              isEdit = false;
                            });
                          },
                          buildActions: [
                            MyTextField(
                              controller: name,
                              labelText: "اسم الحساب",
                            ),
                            SizedBox(height: defaultPadding),
                            MyTextField(
                              controller: cost_USD,
                              labelText: "المبلغ بالدولار",
                            ),
                            SizedBox(height: defaultPadding),
                            MyTextField(
                              controller: cost_IRQ,
                              labelText: "المبلغ بالدينار",
                            ),
                            SizedBox(height: defaultPadding),
                            MyTextField(
                              controller: note,
                              labelText: "الملاحضات",
                            ),
                          ]),
                    ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(),
                        ),
                        TextButton(
                            onPressed: () {
                              Provider.of<WalletProvider>(context,
                                      listen: false)
                                  .getPage(-1, true);
                            },
                            child: Text("الصفحة السابقة")),
                        Consumer<WalletProvider>(
                            builder: (context, walletProvider, child) {
                          return Text("الصفحة : ${walletProvider.page}");
                        }),
                        TextButton(
                            onPressed: () {
                              Provider.of<WalletProvider>(context,
                                      listen: false)
                                  .getPage(1, true);
                            },
                            child: Text("الصفحة التالية")),
                        Expanded(child: SizedBox()),
                      ],
                    ),
                  ),
                  Consumer<WalletProvider>(
                    builder: (context, controller, child) {
                      if (controller.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (controller.isError) {
                        // print(s)
                        return Center(child: MyErrorWidget());
                      } else {
                        return manyTaybel(controller, context, () {
                          setState(() {
                            isEdit = true;
                          });
                        });
                      }
                    },
                  ),
                ],
              ),
              SizedBox(
                width: defaultPadding,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
