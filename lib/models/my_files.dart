import 'package:admin/utl/constants.dart';
import 'package:flutter/material.dart';

class CloudStorageInfo {
  final String? svgSrc, title, totalStorage;
  final int? numOfFiles;
  final Color? color;

  CloudStorageInfo({
    this.svgSrc,
    this.title,
    this.totalStorage,
    this.numOfFiles,
    this.color,
  });
}

List demoMyFiles = [
  CloudStorageInfo(
    title: "عدد الوكلاء",
    numOfFiles: 1328,
    svgSrc: "assets/icons/menu_tran.svg",
    totalStorage: "وكيل",
    color: primaryColor,
  ),
  CloudStorageInfo(
    title: "عدد الرحلات",
    numOfFiles: 1328,
    svgSrc: "assets/icons/menu_task.svg",
    totalStorage: "رحلة",
    color: Color(0xFFFFA113),
  ),
  CloudStorageInfo(
    title: "عدد الفنادق",
    numOfFiles: 1328,
    svgSrc: "assets/icons/menu_store.svg",
    totalStorage: "فندق",
    color: Color(0xFFA4CDFF),
  ),
  CloudStorageInfo(
    title: "عدد الفواتير",
    numOfFiles: 5328,
    svgSrc: "assets/icons/menu_doc.svg",
    totalStorage: "فاتورة",
    color: Color(0xFF007EE5),
  ),
];
