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
        title: Header(title: "الحسابات العامه"),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
          Consumer<AuthorityController>(builder: (context, myType, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: (){
                  myType.changeType();
                  },
                  child: Card(
                    child: Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 3,vertical: 10),
                                child: Text(
                              myType.type == false ? "عرض الارشيف" : 'رجوع',
                              style: TextStyle(fontSize: 23),
                            )),
                            Icon(
                             myType.type == false ?  Icons.archive:Icons.arrow_back,
                              size: 40,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
          CardTable()
        ],
      ),
    );
  }
}
