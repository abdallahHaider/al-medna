import 'package:admin/controllers/wallet_provider.dart';
import 'package:admin/models/action.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/many%20send/many_taybl.dart';
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
  @override
  void initState() {
    Provider.of<WalletProvider>(context, listen: false).getWallet(true);
    super.initState();
  }

  @override
  void dispose() {
    // Provider.of<WalletProvider>(context, listen: false).dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Header(title: "الصرفيات"),
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
                              // ElevatedButton(
                              //     style: ButtonStyle(
                              //       backgroundColor:
                              //           WidgetStateProperty.all(primaryColor),
                              //       shape: WidgetStateProperty.all(
                              //         RoundedRectangleBorder(
                              //           borderRadius: BorderRadius.circular(5),
                              //         ),
                              //       ),
                              //       foregroundColor:
                              //           WidgetStateProperty.all(Colors.white),
                              //     ),
                              //     onPressed: () {
                              //       Provider.of<Rootwidget>(context,
                              //               listen: false)
                              //           .getWidet(WalletAction());
                              //     },
                              //     child: Text("اضافة صرف")),
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
                        SizedBox(
                          height: defaultPadding,
                        ),
                        Consumer<WalletProvider>(
                          builder: (context, controller, child) {
                            if (controller.isLoading) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (controller.isError) {
                              // print(s)
                              return Center(child: MyErrorWidget());
                            } else {
                              return manyTaybel(controller, context);
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
                  child: AddPay(),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}

class AddPay extends StatefulWidget {
  AddPay({
    super.key,
  });

  @override
  State<AddPay> createState() => _AddPayState();
}

class _AddPayState extends State<AddPay> {
  final TextEditingController costUSD = TextEditingController();

  final TextEditingController costDIQ = TextEditingController();

  final TextEditingController description = TextEditingController();

  final TextEditingController name = TextEditingController();

  String type = "";

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: secondaryColor,
      child: SizedBox(
        height: 500,
        child:
            Consumer<WalletProvider>(builder: (context, walletProvider, child) {
          return Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("اضافة صرفية",
                    style: TextStyle(fontSize: 20, color: Colors.black)),
                SizedBox(
                  height: defaultPadding,
                ),
                DropdownButtonFormField<dynamic>(
                    decoration: InputDecoration(
                      labelText: "نوع العملية",
                      border: OutlineInputBorder(),
                    ),
                    // value: TypeAction.actions.isEmpty ? null : null,
                    items: TypeAction.actions.map((dynamic toElement) {
                      return DropdownMenuItem(
                        child: Text(toElement.name),
                        value: toElement,
                      );
                    }).toList(),
                    onChanged: (value) {
                      type = value!.id;
                    }),
                SizedBox(
                  height: defaultPadding,
                ),
                MyTextField(
                  controller: name,
                  labelText: "اسم المستلم",
                ),
                SizedBox(
                  height: defaultPadding,
                ),
                MyTextField(
                  controller: costDIQ,
                  labelText: "المبلغ بالدينار",
                ),
                SizedBox(
                  height: defaultPadding,
                ),
                MyTextField(
                  controller: costUSD,
                  labelText: "المبلغ بالدولار",
                ),
                SizedBox(
                  height: defaultPadding,
                ),
                MyTextField(
                  controller: description,
                  labelText: "ملاحضة",
                ),
                SizedBox(
                  height: defaultPadding,
                ),
                ElevatedButton(
                  onPressed: () {
                    Provider.of<WalletProvider>(context, listen: false).Addpay(
                      true,
                      type,
                      "0",
                      name.text,
                      // dinarCostController.text.isNotEmpty
                      costDIQ.text,
                      costUSD.text,
                      description.text,
                      context,
                    );
                  },
                  child: Text("اضافة صرفية"),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
