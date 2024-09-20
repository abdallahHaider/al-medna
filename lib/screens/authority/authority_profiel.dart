import 'package:admin/controllers/authority_controller.dart';
import 'package:admin/controllers/transactions.dart';
import 'package:admin/models/authority_tickt.dart';
import 'package:admin/screens/authority/widget/add_ticks.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/widgets/deleteDialog.dart';
import 'package:admin/screens/widgets/my_text_field.dart';
import 'package:admin/utl/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthorityProfile extends StatefulWidget {
  const AuthorityProfile({super.key, required this.id, required this.name});
  final String id;
  final String name;

  @override
  State<AuthorityProfile> createState() => _AuthorityProfileState();
}

class _AuthorityProfileState extends State<AuthorityProfile> {
  bool isEdit = false;
  int id = 0;
  final number = TextEditingController();
  final cost = TextEditingController();
  final commission = TextEditingController();
  final ScrollController controllerOne = ScrollController();

  @override
  void initState() {
    Provider.of<AuthorityController>(context, listen: false)
        .getAuthorityTicks(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Header(
            title: 'حساب: ${widget.name}',
          ),
        ),
        Row(
          children: [
            TextButton(
                onPressed: () {
                  Provider.of<AuthorityController>(context, listen: false)
                      .setpage(-1);
                  Provider.of<AuthorityController>(context, listen: false)
                      .getAuthorityTicks(widget.id);
                },
                child: Text("الصفحة السابقة")),
            Consumer<AuthorityController>(
              builder: (context, myType, child) {
                return Text("الصفحة :${myType.page}");
              },
            ),
            TextButton(
                onPressed: () {
                  Provider.of<AuthorityController>(context, listen: false)
                      .setpage(1);
                  Provider.of<AuthorityController>(context, listen: false)
                      .getAuthorityTicks(widget.id);
                },
                child: Text("الصفحة التالية")),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Card(
                child: Consumer<AuthorityController>(
                  builder: (context, myType, child) {
                    return Scrollbar(
                      controller: controllerOne,
                      child: SingleChildScrollView(
                        controller: controllerOne,
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                            columns: [
                              DataColumn(
                                label: Text('الاسم'),
                              ),
                              DataColumn(label: Text(" عدد   كبير")),
                              DataColumn(label: Text("سعر كبير")),
                              DataColumn(label: Text("عدد  صغير")),
                              DataColumn(label: Text("سعر  صغير")),
                              DataColumn(label: Text(" الأجر")),
                              // DataColumn(label: Text(" الواصل")),
                              DataColumn(label: Text("الاجمالي")),
                              DataColumn(label: Text("القيد")),

                              DataColumn(label: Text("التاريخ")),
                              DataColumn(label: Text("الاجراء"))
                            ],
                            rows: List.generate(myType.authoritiesT.length,
                                (index) {
                              AuthorityTickt authority =
                                  myType.authoritiesT[index];
                              return DataRow(
                                  color: int.parse(authority.number_kade!) > 0
                                      ? WidgetStateProperty.all(
                                          Colors.grey.shade300)
                                      : null,
                                  cells: [
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
                                    DataCell(
                                        Text(authority.number_kade.toString())),
                                    DataCell(Text(authority.createdAt
                                        .toString()
                                        .substring(0, 10))),
                                    DataCell(Row(
                                      children: [
                                        if (int.parse(authority.number_kade!) <
                                            1)
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
                                              if (int.parse(
                                                      authority.number_kade!) >
                                                  0) {
                                                await Provider.of<
                                                            TransactionsController>(
                                                        context,
                                                        listen: false)
                                                    .deletSmallbank(
                                                        authority.id!);
                                              } else {
                                                await deleteDialog(context,
                                                    () async {
                                                  await Provider.of<
                                                              AuthorityController>(
                                                          context,
                                                          listen: false)
                                                      .deleteAuthorityTicks(
                                                          authority.id!,
                                                          context);
                                                });
                                              }
                                              Provider.of<AuthorityController>(
                                                      context,
                                                      listen: false)
                                                  .getAuthorityTicks(widget.id);
                                            },
                                            icon: Icon(Icons.delete)),
                                      ],
                                    ))
                                  ]);
                            })),
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Card(
                        child: SizedBox(
                      width: double.maxFinite,
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Consumer<AuthorityController>(
                            builder: (context, myType, child) {
                              return Column(
                                children: [
                                  Text("مجموع الطلب",
                                      style: TextStyle(fontSize: 18)),
                                  Text(myType.allCost.toString(),
                                      style: TextStyle(fontSize: 20)),
                                  SizedBox(
                                    height: defaultPadding * 2,
                                  ),
                                  Text(
                                    "مجموع السداد",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Text(myType.paid.toString(),
                                      style: TextStyle(fontSize: 20)),
                                  SizedBox(
                                    height: defaultPadding * 2,
                                  ),
                                  Text(" المتبقي",
                                      style: TextStyle(fontSize: 18)),
                                  Text(myType.rest.toString(),
                                      style: TextStyle(
                                          color: myType.rest < 0
                                              ? Colors.red
                                              : null,
                                          fontSize: 20)),
                                ],
                              );
                            },
                          )),
                    )),
                    if (isEdit)
                      undetected(
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
                    addTicks(widget: widget),
                  ],
                ),
              ),
            )
          ],
        ),
      ],
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
