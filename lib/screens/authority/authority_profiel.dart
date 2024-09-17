import 'package:admin/controllers/authority_controller.dart';
import 'package:admin/models/authority_tickt.dart';
import 'package:admin/screens/accounts/acconunt_profael.dart';
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
                                  DataColumn(label: Text("عدد المسافرين")),
                                  DataColumn(label: Text("سعر")),
                                  DataColumn(label: Text("العمولة")),
                                  DataColumn(label: Text("الاجمالي")),
                                  DataColumn(label: Text("الاجراء"))
                                ],
                                rows: List.generate(myType.authoritiesT.length,
                                    (index) {
                                  AuthorityTickt authority =
                                      myType.authoritiesT[index];
                                  return DataRow(cells: [
                                    DataCell(
                                      Text(
                                          authority.numberOfTravel!.toString()),
                                      // onTap: () => Provider.of<Rootwidget>(context, listen: false)
                                      //     .getWidet(AuthorityProfile(
                                      //   id: authority.id!.toString(),
                                      // )),
                                    ),
                                    DataCell(Text(
                                        authority.priceOfTravel.toString())),
                                    DataCell(
                                        Text(authority.commission.toString())),
                                    DataCell(
                                        Text(authority.totalPrice.toString())),
                                    DataCell(Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              // myType.id =
                                              //     authority.id!.toString();
                                              // myType.setedit(true);
                                            },
                                            icon: Icon(Icons.edit)),
                                        IconButton(
                                            onPressed: () async {
                                              await deleteDialog(context,
                                                  () async {
                                                // await Provider.of<AuthorityController>(context,
                                                //         listen: false)
                                                //     .deletAuthority(authority.id!, context);
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
                    SizedBox(
                      width: 500,
                      child: Card(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(defaultPadding),
                              child: Header(title: "اضافة حجز"),
                            ),
                            SizedBox(
                              height: defaultPadding,
                            ),
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
                            SizedBox(
                              height: defaultPadding,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  Provider.of<AuthorityController>(context,
                                          listen: false)
                                      .addAuthorityTicks(widget.id, number.text,
                                          cost.text, commission.text, context);
                                },
                                child: Text("اضافة"))
                          ],
                        ),
                      ),
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
