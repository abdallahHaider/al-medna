import 'package:admin/controllers/authority_controller.dart';
import 'package:admin/screens/authority/widget/add_authority.dart';
import 'package:admin/screens/authority/widget/card_table.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/edit_widget.dart';
import 'package:admin/screens/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthorityPage extends StatefulWidget {
  const AuthorityPage({super.key});

  @override
  State<AuthorityPage> createState() => _AuthorityPageState();
}

class _AuthorityPageState extends State<AuthorityPage> {
  final name = TextEditingController();
  @override
  void initState() {
    Provider.of<AuthorityController>(context, listen: false).getAuthority();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Header(title: "حسابات الهيئة"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              AddAuthority(),
              Consumer<AuthorityController>(
                builder: (context, myType, child) {
                  if (myType.isEdit) {
                    return SizedBox(
                      width: 500,
                      child: EditWidget(
                          savePressed: () async {
                            await myType.updateAuthority(name.text, context);
                            myType.getAuthority();
                          },
                          canselPressed: () {
                            myType.setedit(false);
                          },
                          buildActions: [
                            MyTextField(
                              controller: name,
                              labelText: "اسم الهيئة",
                            )
                          ]),
                    );
                  } else {
                    return SizedBox();
                  }
                },
              ),
            ],
          ),
          CardTable()
        ],
      ),
    );
  }
}
