import 'package:flutter/material.dart';
import 'package:admin/controllers/wallet_provider.dart';

class EditWalletDialog extends StatelessWidget {
  final Wallet wallet; // تمرير بيانات العملية
  final WalletProvider walletProvider; // تمرير التحكم بالمحفظة

  EditWalletDialog({required this.wallet, required this.walletProvider});

  @override
  Widget build(BuildContext context) {
    // المتحكمات بالنصوص لملء حقول الإدخال بالبيانات الحالية
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
            ),
            TextField(
              controller: costUSDController,
              decoration: InputDecoration(labelText: 'المبلغ بالدولار'),
              keyboardType: TextInputType.number,
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
            // walletProvider.updateWallet(
            //   wallet.id,
            //   ownerController.text,
            //   double.tryParse(costIQDController.text) ?? 0,
            //   double.tryParse(costUSDController.text) ?? 0,
            //   context,
            // );
            // Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
