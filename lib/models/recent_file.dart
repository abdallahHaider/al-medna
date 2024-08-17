import 'package:flutter/material.dart';

class RecentFile {
  final Color color;
  final String? icon, title, date, size;
  final Widget? widget;

  RecentFile(
      {this.icon,
      this.title,
      this.date,
      this.size,
      required this.color,
      this.widget});
}

List demoRecentFiles = [
  RecentFile(
    icon: "assets/icons/menu_task.svg",
    title: "انشاء رحلة",
    date: "01-03-2021",
    size: "اجمالي المبلغ 500 دولار",
    color: Colors.green,
    // widget: ResellerPage(),
  ),
  RecentFile(
    icon: "assets/icons/menu_task.svg",
    title: "مسح رحلة",
    date: "27-02-2021",
    size: "لا يوجد",
    color: Colors.red,
    //  widget: ResellerPage(),
  ),
  RecentFile(
    icon: "assets/icons/menu_doc.svg",
    title: "تسديد رحلة",
    date: "23-02-2021",
    size: "اجمالي التسديد 500 دولار",
    color: Colors.green,
  ),
  RecentFile(
    icon: "assets/icons/menu_doc.svg",
    title: "حذف تسديده",
    date: "23-02-2021",
    size: "مبلغ التسديدة  500 دولار",
    color: Colors.red,
  ),
];
