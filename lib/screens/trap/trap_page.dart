import 'package:admin/controllers/trap_controller%20.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../controllers/hotel_controller.dart';
import '../../controllers/reseller_controller.dart';
import '../dashboard/components/header.dart';
import 'package:admin/utl/constants.dart';
import 'package:admin/screens/widgets/erorr_widget.dart';

class TrapPage extends StatefulWidget {
  @override
  State<TrapPage> createState() => _TrapPageState();
}

class _TrapPageState extends State<TrapPage> {
  final duration = TextEditingController();

  final quantity = TextEditingController();

  final pricePerOne = TextEditingController();

  final rasToUsd = TextEditingController();

  final iqdToUsd = TextEditingController();

  final _startDateController = TextEditingController();

  final _endDateController = TextEditingController();

  String resslrid = "";

  String trapid = "";

  String transportsid = "";
  int page = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Header(title: 'الرحلات'),
                    ),
                    InkWell(
                      hoverColor: Colors.transparent,
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (c) => AlertDialog(
                                  backgroundColor: Colors.transparent,
                                  content: MultiProvider(
                                    providers: [
                                      ChangeNotifierProvider(
                                        create: (context) =>
                                            ResellerController()
                                              ..getfetchData(),
                                      ),
                                      ChangeNotifierProvider(
                                        create: (context) =>
                                            HotelController()..getfetchData(),
                                      ),
                                      ChangeNotifierProvider(
                                        create: (context) => TrapController(),
                                      ),
                                    ],
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(height: defaultPadding * 5),
                                          Card(
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                  defaultPadding),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Header(
                                                    title: 'اضافة رحلة',
                                                  ),
                                                  SizedBox(
                                                      height: defaultPadding),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Consumer<
                                                            ResellerController>(
                                                          builder: (BuildContext
                                                                  context,
                                                              value,
                                                              Widget? child) {
                                                            return DropdownButtonFormField<
                                                                dynamic>(
                                                              decoration:
                                                                  InputDecoration(
                                                                border:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                                labelText:
                                                                    "الوكيل",
                                                                fillColor: Theme.of(
                                                                        context)
                                                                    .scaffoldBackgroundColor,
                                                              ),
                                                              onChanged:
                                                                  (dynamic
                                                                      value) {
                                                                resslrid = value
                                                                    .id
                                                                    .toString();
                                                              },
                                                              items: value
                                                                  .resellerss
                                                                  .map((dynamic
                                                                      companies) {
                                                                return DropdownMenuItem<
                                                                    dynamic>(
                                                                  value:
                                                                      companies,
                                                                  child: Text(
                                                                      companies
                                                                          .fullName!),
                                                                );
                                                              }).toList(),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          width:
                                                              defaultPadding),
                                                      Expanded(
                                                        child: Consumer<
                                                            HotelController>(
                                                          builder: (BuildContext
                                                                  context,
                                                              value,
                                                              Widget? child) {
                                                            return DropdownButtonFormField<
                                                                dynamic>(
                                                              decoration:
                                                                  InputDecoration(
                                                                border:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                                labelText:
                                                                    "الفندق",
                                                                fillColor: Theme.of(
                                                                        context)
                                                                    .scaffoldBackgroundColor,
                                                              ),
                                                              onChanged:
                                                                  (dynamic
                                                                      value) {
                                                                trapid = value
                                                                    .id
                                                                    .toString();
                                                              },
                                                              items: value
                                                                  .hotels
                                                                  .map((dynamic
                                                                      companies) {
                                                                return DropdownMenuItem<
                                                                    dynamic>(
                                                                  value:
                                                                      companies,
                                                                  child: Text(
                                                                      companies
                                                                          .fullName!),
                                                                );
                                                              }).toList(),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                      height: defaultPadding),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Consumer<
                                                            TrapController>(
                                                          builder: (BuildContext
                                                                  context,
                                                              value,
                                                              Widget? child) {
                                                            return DropdownButtonFormField<
                                                                dynamic>(
                                                              decoration:
                                                                  InputDecoration(
                                                                border:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                                labelText:
                                                                    "الرحلة",
                                                                fillColor: Theme.of(
                                                                        context)
                                                                    .scaffoldBackgroundColor,
                                                              ),
                                                              onChanged:
                                                                  (dynamic
                                                                      value) {
                                                                transportsid =
                                                                    value.id;
                                                              },
                                                              items: value
                                                                  .transports
                                                                  .map((dynamic
                                                                      companies) {
                                                                return DropdownMenuItem<
                                                                    dynamic>(
                                                                  value:
                                                                      companies,
                                                                  child: Text(
                                                                      companies
                                                                          .name),
                                                                );
                                                              }).toList(),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          width:
                                                              defaultPadding),
                                                      Expanded(
                                                        child: TextFormField(
                                                          controller: duration,
                                                          decoration:
                                                              InputDecoration(
                                                            labelText:
                                                                'مدة الرحلة',
                                                            border:
                                                                OutlineInputBorder(),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                      height: defaultPadding),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: TextFormField(
                                                          controller: quantity,
                                                          decoration:
                                                              InputDecoration(
                                                            labelText:
                                                                'عدد المسافرين',
                                                            border:
                                                                OutlineInputBorder(),
                                                          ),
                                                          keyboardType:
                                                              TextInputType
                                                                  .phone,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          width:
                                                              defaultPadding),
                                                      Expanded(
                                                        child: TextFormField(
                                                          controller:
                                                              pricePerOne,
                                                          decoration:
                                                              InputDecoration(
                                                            labelText:
                                                                'السعر لكل مسافر',
                                                            border:
                                                                OutlineInputBorder(),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                      height: defaultPadding),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: TextFormField(
                                                          controller: iqdToUsd,
                                                          decoration:
                                                              InputDecoration(
                                                            labelText:
                                                                'سعر الصرف الدينار',
                                                            border:
                                                                OutlineInputBorder(),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          width:
                                                              defaultPadding),
                                                      Expanded(
                                                        child: TextFormField(
                                                          controller: rasToUsd,
                                                          decoration:
                                                              InputDecoration(
                                                            labelText:
                                                                'سعر الصرف الريال',
                                                            border:
                                                                OutlineInputBorder(),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                      height: defaultPadding),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      ElevatedButton(
                                                        onPressed: () async {
                                                          await Provider.of<
                                                                      TrapController>(
                                                                  context,
                                                                  listen: false)
                                                              .addtrap(
                                                                  duration.text
                                                                      .toString(),
                                                                  quantity.text
                                                                      .toString(),
                                                                  pricePerOne
                                                                      .text
                                                                      .toString(),
                                                                  rasToUsd.text
                                                                      .toString(),
                                                                  iqdToUsd.text
                                                                      .toString(),
                                                                  context,
                                                                  resslrid,
                                                                  transportsid,
                                                                  trapid);
                                                        },
                                                        child: Text('اضافة'),
                                                      ),
                                                      InkWell(
                                                        child: Text(
                                                          "الغاء",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.red),
                                                        ),
                                                        onTap: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ]),
                                  ),
                                ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 26, 26, 48),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 7),
                          child: Text("اضافة رحلة"),
                        ),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (c) => AlertDialog(
                                  title: Text("حدد تاريخ"),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        controller: _startDateController,
                                        decoration: InputDecoration(
                                          labelText: "تاريخ من",
                                          border: OutlineInputBorder(),
                                          filled: true,
                                        ),
                                        onTap: () async {
                                          final DateTime? picker =
                                              await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2000),
                                            lastDate: DateTime.now()
                                                .add(Duration(days: 100)),
                                          );
                                          if (picker != null) {
                                            // setState(() {
                                            _startDateController.text = picker
                                                .toString()
                                                .substring(0, 10);
                                            // });
                                          }
                                        },
                                      ),
                                      TextField(
                                        controller: _endDateController,
                                        decoration: InputDecoration(
                                          labelText: "تاريخ الى",
                                          border: OutlineInputBorder(),
                                          filled: true,
                                        ),
                                        onTap: () async {
                                          final DateTime? picker =
                                              await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2000),
                                            lastDate: DateTime.now()
                                                .add(Duration(days: 100)),
                                          );
                                          if (picker != null) {
                                            // setState(() {
                                            _endDateController.text = picker
                                                .toString()
                                                .substring(0, 10);
                                            // });
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("الغاء"),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        if (_startDateController.text.isEmpty ||
                                            _endDateController.text.isEmpty) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                                content: Text(
                                                    "من فضلك ادخل تاريخ من و الى")),
                                          );
                                        } else {
                                          // await Provider.of<TrapController>(
                                          //         context,
                                          //         listen: false)
                                          //     .fetchData(
                                          // "?start_date=${_startDateController.text}&end_date=${_endDateController.text}");
                                          page=1;
                                          Provider.of<TrapController>(context,
                                                  listen: false)
                                              .updete();
                                          Navigator.of(context).pop();
                                          // _startDateController.text = "";
                                          // _endDateController.text = "";
                                        }
                                      },
                                      child: Text("حسنا"),
                                    ),
                                  ],
                                ));
                      },
                      label: Text("بحث متقدم"),
                      icon: Icon(Icons.search),
                    )
                  ],
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Consumer<TrapController>(
                          builder: (context, value, _) {
                            print("111111111111111111111111");
                            print(_startDateController.text.isEmpty);
                            return FutureBuilder(
                              future: value.fetchData(
                                  _startDateController.text.isEmpty
                                      ? ""
                                      : "&start_date=${_startDateController.text}&end_date=${_endDateController.text}",
                                  page),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  return ErorrWidget();
                                } else if (snapshot.hasData) {
                                  print(snapshot.data!);
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: secondaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text('معلومات عامة'),
                                              SizedBox(
                                                height: defaultPadding,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                        "التلكفة الاجمالية بالدولار : ${snapshot.data!['total_cost_USD'].toString()}"),
                                                    Text(
                                                        "التلكفة الاجمالية بالدينار : ${snapshot.data!['total_cost_IQD'].toString()}"),
                                                    Text(
                                                        "التلكفة الاجمالية بالريل السعودي : ${snapshot.data!['total_cost_RAS'].toString()}"),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12),
                                                child: Divider(),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                        "المبلغ المدفوع بالدولار: ${snapshot.data!['total_cost_USD_pays'].toString()}"),
                                                    Text(
                                                        "المبلغ المدفوع بالدينار: ${snapshot.data!['total_cost_IQD_pays'].toString()}"),
                                                    Text(
                                                        "المبلغ المدفوع بالريل السعودي: ${snapshot.data!['total_cost_RAS_pays'].toString()}"),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12),
                                                child: Divider(),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "الارباح بالدينار: ${(snapshot.data!['total_cost_IQD_pays'] - snapshot.data!['total_cost_IQD']).toString()}",
                                                      style: TextStyle(
                                                          color: snapshot.data![
                                                                          'total_cost_IQD_pays'] -
                                                                      snapshot.data![
                                                                          'total_cost_IQD'] <
                                                                  0
                                                              ? Colors.red
                                                              : Colors.green),
                                                    ),
                                                    Text(
                                                      "الارباح بالريال: ${(snapshot.data!['total_cost_RAS_pays'] - snapshot.data!['total_cost_RAS']).toString()}",
                                                      style: TextStyle(
                                                          color: snapshot.data![
                                                                          'total_cost_RAS_pays'] -
                                                                      snapshot.data![
                                                                          'total_cost_RAS'] <
                                                                  0
                                                              ? Colors.red
                                                              : Colors.green),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12),
                                                child: Divider(),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text('عدد التسديدات :' +
                                                        snapshot
                                                            .data!['count_pays']
                                                            .toString()),
                                                    Text(
                                                        "المدة الزمنية : ${snapshot.data!['start_date'] == null ? "لا يوجد" : " من " + snapshot.data!['start_date'] + " الى " + snapshot.data!['end_date']}"),
                                                    Text('عدد الرحلات :' +
                                                        snapshot
                                                            .data!['count_trap']
                                                            .toString()),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          ElevatedButton(
                                              onPressed: () {
                                                page += 1;
                                                Provider.of<TrapController>(
                                                        context,
                                                        listen: false)
                                                    .updete();
                                              },
                                              child: Text("الصفحة التالية")),
                                          Text("الصفحة :$page"),
                                          ElevatedButton(
                                              onPressed: () {
                                                if (page > 1) {
                                                  page -= 1;
                                                  Provider.of<TrapController>(
                                                          context,
                                                          listen: false)
                                                      .updete();
                                                }
                                              },
                                              child: Text("الصفحة السابقة")),
                                        ],
                                      ),
                                      Expanded(
                                        child: ListView.builder(
                                          itemCount: snapshot
                                              .data!['resellers'].length,
                                          itemBuilder: (context, index) {
                                            final trip = snapshot
                                                .data!['resellers'][index];
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4,
                                                      horizontal: 8),
                                              child: InkWell(
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (c) {
                                                        return AlertDialog(
                                                          content: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Text(
                                                                'معلومات الرحلة',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20),
                                                              ),
                                                              SizedBox(
                                                                height: 20,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                      "الوكيل"),
                                                                  Text(trip
                                                                      .resellerId!),
                                                                ],
                                                              ),
                                                              Divider(),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                      "وسيلة النقل"),
                                                                  Text(trip.transport ==
                                                                          "fly"
                                                                      ? "جوي"
                                                                      : "بري"),
                                                                ],
                                                              ),
                                                              Divider(),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text("المدة"),
                                                                  Text(trip
                                                                          .duration
                                                                          .toString() +
                                                                      " يوم "),
                                                                ],
                                                              ),
                                                              Divider(),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                      "عدد المسافرين"),
                                                                  Text(trip
                                                                      .quantity
                                                                      .toString()),
                                                                ],
                                                              ),
                                                              Divider(),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                      "السعر بالدولار لكل مسافر"),
                                                                  Text(trip
                                                                      .pricePerOne
                                                                      .toString()),
                                                                ],
                                                              ),
                                                              Divider(),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                      "اجمالي المبلغ بالدولار"),
                                                                  Text((trip.pricePerOne *
                                                                          trip.quantity)
                                                                      .toString()),
                                                                ],
                                                              ),
                                                              Divider(),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                      "قيمة الريال بالنسبه للدولار"),
                                                                  Text(trip
                                                                      .rasToUsd
                                                                      .toString()),
                                                                ],
                                                              ),
                                                              Divider(),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                      "قيمة الدينار بالنسبه للدولار"),
                                                                  Text(trip
                                                                      .iqdToUsd
                                                                      .toString()),
                                                                ],
                                                              ),
                                                              Divider(),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                      "تاريخ الانشاء"),
                                                                  Text(trip
                                                                      .createdAt
                                                                      .toString()
                                                                      .substring(
                                                                          0,
                                                                          11)),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 20,
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                child: Text(
                                                                  "اخفاء",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .red),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        );
                                                      });
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(8.0),
                                                  decoration: BoxDecoration(
                                                    color: secondaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          CircleAvatar(
                                                            backgroundColor:
                                                                primaryColor,
                                                            child: trip.transport ==
                                                                    'fly'
                                                                ? SvgPicture
                                                                    .asset(
                                                                    'assets/icons/menu_task.svg',
                                                                    width: 25,
                                                                    height: 25,
                                                                    color: Colors
                                                                        .white,
                                                                  )
                                                                : SvgPicture.asset(
                                                                    'assets/icons/bus.svg',
                                                                    width: 25,
                                                                    height: 25,
                                                                    color: Colors
                                                                        .white),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(trip
                                                                  .resellerId!),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Text(
                                                                trip.hotelId
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey),
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Text(
                                                                (trip.pricePerOne *
                                                                            trip.quantity)
                                                                        .toString() +
                                                                    " دولار ",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      InkWell(
                                                        hoverColor:
                                                            Colors.transparent,
                                                        onTap: () {
                                                          showDialog(
                                                            context: context,
                                                            builder: (c) =>
                                                                AlertDialog(
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              content: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  SizedBox(
                                                                      height:
                                                                          defaultPadding *
                                                                              5),
                                                                  Card(
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          defaultPadding),
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Header(
                                                                              title: 'حذف رحلة'),
                                                                          SizedBox(
                                                                              height: defaultPadding),
                                                                          Text(
                                                                              "هل انت متأكد من أنك تريد حذف الرحلة؟"),
                                                                          SizedBox(
                                                                              height: 10),
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              ElevatedButton(
                                                                                onPressed: () async {
                                                                                  await Provider.of<TrapController>(context, listen: false).delete(trip.id, context);
                                                                                },
                                                                                child: Text('حذف'),
                                                                              ),
                                                                              InkWell(
                                                                                child: Text("الغاء", style: TextStyle(color: Colors.red)),
                                                                                onTap: () {
                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        child: Icon(
                                                            Icons
                                                                .delete_forever_outlined,
                                                            color: Colors
                                                                .redAccent),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                } else {
                                  return Center(child: Text('لا توجد بيانات'));
                                }
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
