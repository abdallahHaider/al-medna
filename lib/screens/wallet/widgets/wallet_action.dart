import 'package:admin/controllers/wallet_provider.dart';
import 'package:admin/models/action.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/widgets/my_text_field.dart';
import 'package:admin/utl/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WalletAction extends StatefulWidget {
  WalletAction({
    super.key,
  });

  @override
  State<WalletAction> createState() => _WalletActionState();
}

class _WalletActionState extends State<WalletAction> {
  final costController = TextEditingController();
  final descriptionController = TextEditingController();
  final kadeCostController = TextEditingController();
  final ownerController = TextEditingController();
  final itod = TextEditingController();
  String type = "";

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(title: "اضافة عملية"),
            SizedBox(height: defaultPadding),
            DropdownButtonFormField<TypeAction>(
                decoration: InputDecoration(
                  labelText: "نوع العملية",
                  border: OutlineInputBorder(),
                ),
                items: TypeAction.actions.map((TypeAction toElement) {
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
            // DropdownButtonFormField<TypeCost>(
            //     decoration: InputDecoration(
            //       labelText: "نوع العملة",
            //       border: OutlineInputBorder(),
            //     ),
            //     items: TypeCost.costs.map((TypeCost toElement) {
            //       return DropdownMenuItem(
            //         child: Text(toElement.name),
            //         value: toElement,
            //       );
            //     }).toList(),
            //     onChanged: (value) {}),
            //      SizedBox(
            //   height: defaultPadding,
            // ),
            MyTextField(
              controller: kadeCostController,
              labelText: 'رقم العقد',
            ),
            SizedBox(
              height: defaultPadding,
            ),
            MyTextField(
              controller: ownerController,
              labelText: 'الاسم',
            ),
            SizedBox(
              height: defaultPadding,
            ),
            MyTextField(
              controller: costController,
              labelText: 'المبلغ',
              onChanged: (String value) {
                Provider.of<WalletProvider>(context, listen: false)
                    .setNumberWord(value);
              },
            ),
            SizedBox(
              height: defaultPadding,
            ),
            Consumer<WalletProvider>(
              builder: (context, watch, child) {
                return MyTextField(
                  controller: TextEditingController(text: watch.numberWord),
                  labelText: 'المبلغ كتابتا',
                  enabled: false,
                );
              },
            ),
            SizedBox(
              height: defaultPadding,
            ),
            MyTextField(
              controller: itod,
              labelText: 'سعر الصرف',
            ),
            SizedBox(
              height: defaultPadding,
            ),
            MyTextField(
              controller: descriptionController,
              labelText: 'ملاحضة',
            ),
            SizedBox(
              height: defaultPadding,
            ),
            SizedBox(
              width: double.maxFinite,
              child: ElevatedButton(
                onPressed: () {
                  Provider.of<WalletProvider>(context, listen: false).Addpay(
                      type,
                      kadeCostController.text.toString(),
                      ownerController.text.toString(),
                      costController.text.toString(),
                      itod.text.toString(),
                      descriptionController.text.toString(),
                      context);
                },
                child: Text('اضافة'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
