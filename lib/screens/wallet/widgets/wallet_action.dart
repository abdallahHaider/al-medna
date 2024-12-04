import 'package:admin/controllers/rootWidget.dart';
import 'package:admin/controllers/wallet_provider.dart';
import 'package:admin/models/action.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/wallet/wallet_page.dart';
import 'package:admin/screens/widgets/back_batten.dart';
import 'package:admin/utl/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WalletAction extends StatefulWidget {
  WalletAction(
      {Key? key,
      required this.isAdd,
      this.cost_USD,
      this.cost_AQR,
      this.not,
      this.id})
      : super(key: key);

  final bool isAdd;
  final String? cost_USD;
  final String? cost_AQR;
  final String? not;
  final id;

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
    dinarCostController.text = widget.cost_AQR ?? "";
    dollarCostController.text = widget.cost_USD ?? "";
    descriptionController.text = widget.not ?? "";
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
    return Scaffold(
      appBar: AppBar(
        title: Header(title: "الصندوق الرئيسي"),
        actions: [
          BackBatten(
            onPressed: () {
              Provider.of<Rootwidget>(context, listen: false)
                  .getWidet(WalletPage());
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Header(title: ". إضافة عملية"),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: 770, child: _buildDropdownField()),
        const SizedBox(height: 16),
        _buildTextField(
            controller: ownerController, label: "الاسم", enabled: widget.isAdd),
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
        SizedBox(
          width: 770,
          child: _buildTextField(
            controller: descriptionController,
            label: "ملاحظة",
            maxLines: 3,
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField() {
    return DropdownButtonFormField<TypeAction>(
        enableFeedback: widget.isAdd,
        decoration: InputDecoration(
            labelText: "نوع العملية",
            border: OutlineInputBorder(),
            enabled: widget.isAdd),
        items: !widget.isAdd
            ? []
            : TypeAction.actions.map((TypeAction toElement) {
                return DropdownMenuItem(
                  child: Text(toElement.name),
                  value: toElement,
                );
              }).toList(),
        onChanged: (value) {
          type = value!.id;
        });
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    bool? enabled,
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
    return SizedBox(
      width: 770,
      child: ElevatedButton(
        onPressed: () async {
          if (widget.isAdd) {
            await Provider.of<WalletProvider>(context, listen: false).Addpay(
              false,
              type,
              "0",
              ownerController.text,
              // dinarCostController.text.isNotEmpty
              dinarCostController.text,
              dollarCostController.text,
              descriptionController.text,
              context,
            );
          } else {
            await Provider.of<WalletProvider>(context, listen: false).updatePay(
              widget.id,
              dinarCostController.text,
              dollarCostController.text,
              descriptionController.text,
              context,
            );
          }
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
    );
  }
}
