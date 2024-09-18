import 'package:admin/controllers/authority_controller.dart';
import 'package:admin/models/authority_tickt.dart';
import 'package:admin/screens/accounts/acconunt_profael.dart';
import 'package:admin/screens/authority/widget/add_ticks.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/widgets/deleteDialog.dart';
import 'package:admin/screens/widgets/my_text_field.dart';
import 'package:admin/utl/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthorityProfile extends StatefulWidget {
  const AuthorityProfile({super.key, required this.id});
  final String id;

  @override
  State<AuthorityProfile> createState() => _AuthorityProfileState();
}

class _AuthorityProfileState extends State<AuthorityProfile> {
  bool isEdit = false;
  int id = 0;
  final number = TextEditingController();
  final cost = TextEditingController();
  final commission = TextEditingController();

  @override
  void initState() {
    Provider.of<AuthorityController>(context, listen: false)
        .getAuthorityTicks(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(isScrollable: true, tabs: [
            Tab(
              text: "الحجز",
            ),
            Tab(
              text: "التسديد",
            )
          ]),
          Expanded(
            child: TabBarView(children: [
              SizedBox(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Card(
                        child: Consumer<AuthorityController>(
                          builder: (context, myType, child) {
                            return DataTable(
                                columns: [
                                  DataColumn(
                                    label: Text('الاسم'),
                                  ),
                                  DataColumn(label: Text("عدد المسافرين")),
                                  DataColumn(label: Text("سعر")),
                                  DataColumn(label: Text("عدد الاطفال")),
                                  DataColumn(label: Text("سعر الاطفال")),
                                  DataColumn(label: Text("العمولة")),
                                  DataColumn(label: Text("الاجمالي")),
                                  DataColumn(label: Text("الاجراء"))
                                ],
                                rows: List.generate(myType.authoritiesT.length,
                                    (index) {
                                  AuthorityTickt authority =
                                      myType.authoritiesT[index];
                                  return DataRow(cells: [
                                    DataCell(Text(authority.name!)),
                                    DataCell(
                                      Text(
                                          authority.numberOfTravel!.toString()),
                                    ),
                                    DataCell(Text(
                                        authority.priceOfTravel.toString())),
                                    DataCell(Text(
                                        authority.number_of_child!.toString())),
                                    DataCell(Text(
                                        authority.price_of_child.toString())),
                                    DataCell(
                                        Text(authority.commission.toString())),
                                    DataCell(
                                        Text(authority.totalPrice.toString())),
                                    DataCell(Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              cost.text = authority
                                                  .numberOfTravel!
                                                  .toString();
                                              number.text = authority
                                                  .numberOfTravel!
                                                  .toString();
                                              commission.text = authority
                                                  .commission
                                                  .toString();
                                              setState(() {
                                                isEdit = true;
                                                id = authority.id!;
                                              });
                                            },
                                            icon: Icon(Icons.edit)),
                                        IconButton(
                                            onPressed: () async {
                                              await deleteDialog(context,
                                                  () async {
                                                await Provider.of<
                                                            AuthorityController>(
                                                        context,
                                                        listen: false)
                                                    .deleteAuthorityTicks(
                                                        authority.id!, context);
                                                Provider.of<AuthorityController>(
                                                        context,
                                                        listen: false)
                                                    .getAuthorityTicks(
                                                        widget.id);
                                              });
                                            },
                                            icon: Icon(Icons.delete)),
                                      ],
                                    ))
                                  ]);
                                }));
                          },
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        if (isEdit)
                          SizedBox(
                            width: 500,
                            child: undetected(
                              id: id,
                              number: number,
                              cost: cost,
                              commission: commission,
                              onPressed: () {
                                setState(() {
                                  isEdit = false;
                                });
                              },
                              onerid: widget.id,
                            ),
                          ),
                        SizedBox(
                          width: 500,
                          child: addTicks(widget: widget),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                child: AcconuntProfael_page(
                  id: widget.id,
                  isBank: "H",
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }
}

class undetected extends StatelessWidget {
  undetected({
    super.key,
    required this.id,
    required this.number,
    required this.cost,
    required this.commission,
    required this.onPressed,
    required this.onerid,
  });
  final int id;
  final String onerid;
  final TextEditingController number;

  final TextEditingController cost;

  final TextEditingController commission;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(title: "تعديل حجز"),
            SizedBox(height: defaultPadding),
            MyTextField(
              labelText: "عدد المسافرين",
              controller: number,
            ),
            SizedBox(
              height: defaultPadding,
            ),
            MyTextField(
              labelText: "السعر لكل مسافر",
              controller: cost,
            ),
            SizedBox(
              height: defaultPadding,
            ),
            MyTextField(
              labelText: "العمولة",
              controller: commission,
            ),
            SizedBox(height: defaultPadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      await Provider.of<AuthorityController>(context,
                              listen: false)
                          .updateAuthorityTicks(id, number.text, cost.text,
                              commission.text, context);
                      Provider.of<AuthorityController>(context, listen: false)
                          .getAuthorityTicks(onerid);
                    },
                    child: Text("تعديل")),
                ElevatedButton(onPressed: onPressed, child: Text("الغاء")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
