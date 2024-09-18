import 'package:admin/controllers/wallet_provider.dart';
import 'package:admin/models/action.dart';
import 'package:admin/screens/widgets/my_text_field.dart';
import 'package:admin/utl/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                    items: TypeAction4.actions.map((dynamic toElement) {
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
