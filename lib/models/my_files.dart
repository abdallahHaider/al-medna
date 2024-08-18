import 'package:admin/screens/hotel/hotel_page.dart';
import 'package:admin/screens/reseller/reseller_page.dart';
import 'package:admin/screens/trap%20pay/trap_pay.dart';
import 'package:admin/screens/trap/add_trap.dart';
import 'package:admin/utl/constants.dart';
import 'package:flutter/material.dart';

class CloudStorageInfo {
  final String? svgSrc, title, totalStorage;
  final int? numOfFiles;
  final Color? color;
  final Widget widget;

  CloudStorageInfo(
      {this.svgSrc,
      this.title,
      this.totalStorage,
      this.numOfFiles,
      this.color,
      required this.widget});
}

List demoMyFiles = [
  CloudStorageInfo(
    title: "عدد الوكلاء",
    numOfFiles: 1328,
    svgSrc: "assets/icons/menu_tran.svg",
    totalStorage: "وكيل",
    color: primaryColor,
    widget: ResellerPage(),
  ),
  CloudStorageInfo(
    title: "عدد الرحلات",
    numOfFiles: 1328,
    svgSrc: "assets/icons/menu_task.svg",
    totalStorage: "رحلة",
    color: Color(0xFFFFA113),
    widget: AddTrapPage(
      isEdidt: false,
    ),
  ),
  CloudStorageInfo(
    title: "عدد الفنادق",
    numOfFiles: 1328,
    svgSrc: "assets/icons/menu_store.svg",
    totalStorage: "فندق",
    color: Color(0xFFA4CDFF),
    widget: HotelPage(),
  ),
  CloudStorageInfo(
    title: "عدد الفواتير",
    numOfFiles: 5328,
    svgSrc: "assets/icons/menu_doc.svg",
    totalStorage: "فاتورة",
    color: Color(0xFF007EE5),
    widget: TrapPayPage(),
  ),
];
