import 'package:admin/controllers/authority_controller.dart';
import 'package:admin/controllers/rootWidget.dart';
import 'package:admin/models/authority.dart';
import 'package:admin/screens/authority/authority_profiel.dart';
import 'package:admin/screens/widgets/deleteDialog.dart';
import 'package:admin/screens/widgets/erorr_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardTable extends StatelessWidget {
  const CardTable({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(child: Consumer<AuthorityController>(
      builder: (context, myType, child) {
        if (myType.isError) {
          return MyErrorWidget();
        }
        return DataTable(
            columns: [
              DataColumn(label: Text("الاسم")),
              DataColumn(label: Text("التاريخ")),
              DataColumn(label: Text("الاجراء"))
            ],
            rows: List.generate(myType.authorities.length, (index) {
              Authority authority = myType.authorities[index];
              return DataRow(cells: [
                DataCell(
                  Text(authority.name!),
                  onTap: () => Provider.of<Rootwidget>(context, listen: false)
                      .getWidet(AuthorityProfile(
                    id: authority.id!.toString(),
                  )),
                ),
                DataCell(Text(authority.createdAt.toString().substring(0, 10))),
                DataCell(Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          myType.id = authority.id!.toString();
                          myType.setedit(true);
                        },
                        icon: Icon(Icons.edit)),
                    IconButton(
                        onPressed: () async {
                          await deleteDialog(context, () async {
                            await Provider.of<AuthorityController>(context,
                                    listen: false)
                                .deletAuthority(authority.id!, context);
                          });
                        },
                        icon: Icon(Icons.delete)),
                  ],
                ))
              ]);
            }));
      },
    ));
  }
}