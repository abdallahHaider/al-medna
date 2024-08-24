import 'package:admin/controllers/wallet_provider.dart';
import 'package:admin/models/action.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/utl/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WalletAction extends StatefulWidget {
  WalletAction({Key? key}) : super(key: key);

  @override
  State<WalletAction> createState() => _WalletActionState();
}

class _WalletActionState extends State<WalletAction> {
  final dinarCostController = TextEditingController();
  final dollarCostController = TextEditingController();
  final descriptionController = TextEditingController();
  final kadeCostController = TextEditingController();
  final ownerController = TextEditingController();
  String type = "";

  @override
  void initState() {
    super.initState();
    dinarCostController.addListener(_handleCostInputChange);
    dollarCostController.addListener(_handleCostInputChange);
  }

  @override
  void dispose() {
    dinarCostController.removeListener(_handleCostInputChange);
    dollarCostController.removeListener(_handleCostInputChange);
    dinarCostController.dispose();
    dollarCostController.dispose();
    super.dispose();
  }

  void _handleCostInputChange() {
    if (dinarCostController.text.isNotEmpty) {
      dollarCostController.clear();
      Provider.of<WalletProvider>(context, listen: false)
          .setNumberWord(dinarCostController.text, 'دينار');
    } else if (dollarCostController.text.isNotEmpty) {
      dinarCostController.clear();
      Provider.of<WalletProvider>(context, listen: false)
          .setNumberWord(dollarCostController.text, 'دولار');
    } else {
      Provider.of<WalletProvider>(context, listen: false).clearNumberWord();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        margin: const EdgeInsets.all(defaultPadding),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(title: "إضافة عملية"),
              const Divider(
                thickness: 2,
                color: Colors.grey,
              ),
              const SizedBox(height: 20),
              _buildFormFields(),
              const SizedBox(height: 30),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormFields() {
    return Column(
      children: [
        _buildDropdownField(),
        // label: "نوع العملية",
        // items: TypeAction.actions,
        // onChanged: (value) {
        //   setState(() {
        //     type = value!.id;
        //   });
        // },
        // ),
        // const SizedBox(height: 16),
        // _buildTextField(controller: kadeCostController, label: "رقم القيد"),
        const SizedBox(height: 16),
        _buildTextField(controller: ownerController, label: "الاسم"),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                controller: dinarCostController,
                label: "المبلغ (دينار)",
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildTextField(
                controller: dollarCostController,
                label: "المبلغ (دولار)",
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Consumer<WalletProvider>(
          builder: (context, walletProvider, child) {
            return _buildTextField(
              controller: TextEditingController(
                text: walletProvider.numberWord,
              ),
              label: "المبلغ كتابة",
              enabled: false,
            );
          },
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: descriptionController,
          label: "ملاحظة",
          maxLines: 3,
        ),
      ],
    );
  }

  Widget _buildDropdownField() {
    return DropdownButtonFormField<TypeAction>(
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
        });
    // return DropdownButtonFormField<TypeAction>(
    //   decoration: InputDecoration(
    //     labelText: label,
    //     border: OutlineInputBorder(
    //       borderRadius: BorderRadius.circular(12),
    //     ),
    //     filled: true,
    //     fillColor: Colors.grey[200],
    //   ),
    //   items: TypeAction.a.map((TypeAction item) {
    //     return DropdownMenuItem(
    //       value: item,
    //       child: Text(item.name),
    //     );
    //   }).toList(),
    //   onChanged: onChanged,
    // );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    bool enabled = true,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      enabled: enabled,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Center(
      child: SizedBox(
        width: 200,
        child: ElevatedButton(
          onPressed: () {
            Provider.of<WalletProvider>(context, listen: false).Addpay(
              type,
              "0",
              ownerController.text,
              // dinarCostController.text.isNotEmpty
              dinarCostController.text,
              dollarCostController.text,
              descriptionController.text,
              context,
            );
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 18),
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            "إضافة",
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
