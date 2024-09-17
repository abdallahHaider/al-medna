import 'package:admin/controllers/authority_controller.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/widgets/my_text_field.dart';
import 'package:admin/utl/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddAuthority extends StatelessWidget {
  AddAuthority({
    super.key,
  });

  final name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(title: "اضافة حساب"),
            SizedBox(height: defaultPadding),
            MyTextField(
              controller: name,
              labelText: "الاسم",
            ),
            SizedBox(height: defaultPadding),
            ElevatedButton(
                onPressed: () {
                  Provider.of<AuthorityController>(context, listen: false)
                      .addAuthority(name.text, context);
                },
                child: Text("اضافة"))
          ],
        ),
      ),
    );
  }
}
