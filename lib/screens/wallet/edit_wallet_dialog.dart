import 'package:flutter/material.dart';
import 'package:admin/controllers/wallet_provider.dart';
import 'package:intl/intl.dart';

  // دالة لتنسيق الرقم بإضافة الفواصل
  String formatCustomNumber(String value) {
  if (value.isEmpty) return '';
  final number = double.tryParse(value.replaceAll(',', ''));
  if (number == null) return value;
  return NumberFormat('#000,000').format(number);
}

class EditWalletDialog extends StatelessWidget {
  final Wallet wallet; // تمرير بيانات العملية
  final WalletProvider walletProvider; // تمرير التحكم بالمحفظة

  EditWalletDialog({required this.wallet, required this.walletProvider});

 @override
Widget build(BuildContext context) {
  TextEditingController ownerController =
      TextEditingController(text: wallet.owner);
  TextEditingController costIQDController =
      TextEditingController(text: wallet.costIQD?.toString() ?? '');
  TextEditingController costUSDController =
      TextEditingController(text: wallet.costUSD?.toString() ?? '');

  return AlertDialog(
    title: Text('تعديل بيانات المحفظة'),
    content: SingleChildScrollView(
      child: Column(
        children: [
          TextField(
            controller: ownerController,
            decoration: InputDecoration(labelText: 'الاسم'),
          ),
          TextField(
            controller: costIQDController,
            decoration: InputDecoration(labelText: 'المبلغ بالدينار'),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              costIQDController.value = costIQDController.value.copyWith(
                text: formatCustomNumber(value),
                selection: TextSelection.collapsed(
                  offset: formatCustomNumber(value).length,
                ),
              );
            },
          ),
          TextField(
            controller: costUSDController,
            decoration: InputDecoration(labelText: 'المبلغ بالدولار'),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              costUSDController.value = costUSDController.value.copyWith(
                 text: formatCustomNumber(value),
                 selection: TextSelection.collapsed(
                 offset: formatCustomNumber(value).length,
                ),
              );
            },
          ),
        ],
      ),
    ),
    actions: [
      TextButton(
        child: Text('إلغاء'),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      TextButton(
        child: Text('حفظ'),
        onPressed: () {
          // حدد القيم المناسبة هنا وحدث المحفظة
          // ثم أغلق نافذة AlertDialog
        },
      ),
    ],
  );
}
}
