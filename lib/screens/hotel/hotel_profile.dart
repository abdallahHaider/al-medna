import 'package:admin/controllers/hotel_controller.dart';
import 'package:admin/models/hotel_buy.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/hotel/widgets/hotel_pay.dart';
import 'package:admin/screens/widgets/my_text_field.dart';
import 'package:admin/utl/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HotelProfile extends StatefulWidget {
  const HotelProfile({super.key, required this.hotelId});

  final String hotelId;

  @override
  State<HotelProfile> createState() => _HotelProfileState();
}

class _HotelProfileState extends State<HotelProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Header(title: ""),
        ),
        body: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              TabBar(
                  isScrollable: true,
                  physics: ScrollPhysics(parent: BouncingScrollPhysics()),
                  tabs: [
                    Tab(text: "التسديدات"),
                    Tab(text: "شراء الفنادق"),
                    Tab(text: "بيع الفنادق"),
                  ]),
              Expanded(
                child: TabBarView(
                  children: [
                    HotelPay(),
                    HotelBuyPage(
                      hotelId: widget.hotelId,
                    ),
                    HotelSale(),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class HotelSale extends StatelessWidget {
  const HotelSale({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
            flex: 2,
            child: Card(
              color: secondaryColor,
              child: DataTable(columns: [
                DataColumn(label: Text('النوع')),
                DataColumn(label: Text('المبلغ')),
                DataColumn(label: Text('التاريخ')),
              ], rows: []),
            )),
        Expanded(child: Card())
      ],
    );
  }
}

class HotelBuyPage extends StatefulWidget {
  const HotelBuyPage({
    super.key,
    required this.hotelId,
  });
  final String hotelId;

  @override
  State<HotelBuyPage> createState() => _HotelBuyPageState();
}

class _HotelBuyPageState extends State<HotelBuyPage> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _numberController = TextEditingController();
  @override
  void initState() {
    Provider.of<HotelController>(context, listen: false)
        .getHotelBuy(widget.hotelId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
            flex: 2,
            child: Consumer<HotelController>(builder: (
              BuildContext context,
              HotelController hotelController,
              Widget? child,
            ) {
              return Card(
                color: secondaryColor,
                child: DataTable(
                    columns: [
                      DataColumn(label: Text('التاريخ')),
                      DataColumn(label: Text('الغرف')),
                      DataColumn(label: Text('الليالي')),
                      DataColumn(label: Text('سعر الغرفة')),
                      DataColumn(label: Text('المبلغ الكلي')),
                      DataColumn(label: Text('اسم الشركة')),
                      DataColumn(label: Text('رقم الحركة')),
                      DataColumn(label: Text('الاجراء')),
                    ],
                    rows:
                        List.generate(hotelController.hotelbuy.length, (index) {
                      HotelBuy hotelBuy = hotelController.hotelbuy[index];
                      return DataRow(cells: [
                        DataCell(
                          Text(
                            hotelBuy.createdAt.toString().substring(0, 10),
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            hotelBuy.rooms.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            hotelBuy.nights.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            hotelBuy.roomPricePerNight.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            hotelBuy.totalPrice.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            hotelBuy.company.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            hotelBuy.companyProgramId.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        DataCell(ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                Colors.red,
                              ),
                              foregroundColor: WidgetStateProperty.all(
                                Colors.white,
                              ),
                            ),
                            onPressed: () {
                              // drletdHotel(
                              //     context, snapshot, index);
                            },
                            child: Text("حذف"))),
                      ]);
                    })),
              );
            })),
        Expanded(
            child: Card(
          color: secondaryColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 15,
                ),
                Text("انشاء حجز جديد"),
                SizedBox(
                  height: 20,
                ),
                MyTextField(
                  controller: _nameController,
                  labelText: 'عدد الغرف',
                ),
                SizedBox(
                  height: 10,
                ),
                MyTextField(
                  controller: _numberController,
                  labelText: 'عدد الليالي',
                ),
                SizedBox(
                  height: 10,
                ),
                MyTextField(
                  controller: _priceController,
                  labelText: 'السعر لكل غرفة',
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(onPressed: () {}, child: Text("اضافة"))
              ],
            ),
          ),
        ))
      ],
    );
  }
}
