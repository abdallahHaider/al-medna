import 'package:admin/controllers/hotel_controller.dart';
import 'package:admin/models/hotel_type.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/widgets/snakbar.dart';
import 'package:admin/utl/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Padding addHotelForm(BuildContext context) {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final adressController = TextEditingController();

  return Padding(
    padding: const EdgeInsets.all(defaultPadding),
    child: Card(
      color: secondaryColor,
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Header(title: 'اضافة فندق'),
            SizedBox(height: defaultPadding),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'اسم الفندق',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: defaultPadding),
            TextFormField(
              controller: phoneController,
              decoration: InputDecoration(
                labelText: 'رقم الهاتف',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: defaultPadding),
            DropdownButtonFormField<HotelType>(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: "العنوان",
              ),
              onChanged: (value) {
                adressController.text = value!.name.toString();
              },
              items: HotelType.costs.map((HotelType companies) {
                return DropdownMenuItem<HotelType>(
                  value: companies,
                  child: Text(companies.name),
                );
              }).toList(),
              validator: (value) => value == null ? 'يرجى اختيار الوكيل' : null,
            ),
            SizedBox(height: defaultPadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    if (nameController.text.isEmpty ||
                        phoneController.text.isEmpty ||
                        adressController.text.isEmpty) {
                      snackBar(context, 'الرجاء ملئ جميع الحقول', true);
                    } else {
                      await Provider.of<HotelController>(context, listen: false)
                          .addReseller(
                        nameController.text.toString(),
                        phoneController.text.toString(),
                        adressController.text.toString(),
                        context,
                      );
                    }
                  },
                  child: Text('اضافة'),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
