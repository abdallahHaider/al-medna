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
    return Consumer<WalletProvider>(builder: (context, walletProvider, child) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("اضافة صرفية",
                style: TextStyle(fontSize: 20, color: Colors.black)),
            SizedBox(
              height: defaultPadding,
            ),
            Row(
              children: [
                SizedBox(
                  width: 500,
                  child: DropdownButtonFormField<dynamic>(
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
                ),
                SizedBox(
                  width: defaultPadding,
                ),
                SizedBox(
                  width: 500,
                  child: MyTextField(
                    controller: name,
                    labelText: "اسم المستلم",
                  ),
                ),
              ],
            ),
            SizedBox(
              height: defaultPadding,
            ),
            Row(
              children: [
                SizedBox(
                  width: 500,
                  child: MyTextField(
                    controller: costDIQ,
                    labelText: "المبلغ بالدينار",
                  ),
                ),
                SizedBox(
                  width: defaultPadding,
                ),
                SizedBox(
                  width: 500,
                  child: MyTextField(
                    controller: costUSD,
                    labelText: "المبلغ بالدولار",
                  ),
                ),
              ],
            ),
            SizedBox(
              height: defaultPadding,
            ),
            SizedBox(
              width: 500,
              child: MyTextField(
                controller: description,
                labelText: "ملاحضة",
              ),
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
    });
  }
}
