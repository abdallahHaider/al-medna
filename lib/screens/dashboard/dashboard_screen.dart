import 'package:admin/screens/dashboard/components/budget_card.dart';
import 'package:admin/screens/dashboard/components/shortcuts_card.dart';
import 'package:flutter/material.dart';
import '../../utl/constants.dart';
import 'components/header.dart';
import 'package:intl/intl.dart';

import 'components/history_day.dart';

// دالة لتنسيق الرقم بإضافة الفواصل
String formatCustomNumber(String value) {
  if (value.isEmpty) return '';
  final number = double.tryParse(value.replaceAll(',', ''));
  if (number == null) return value;
  return NumberFormat('#,##0')
      .format(number); // يستخدم هذا التنسيق الفاصلة بين الألوف
}

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: defaultPadding,
                      right: defaultPadding,
                      left: defaultPadding),
                  child: Header(
                    title: 'الصفحة الرئيسية',
                  ),
                ),
                SizedBox(height: defaultPadding),
                budgetCard(),
                SizedBox(height: defaultPadding),
                Divider(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: defaultPadding),
                  child: Header(
                    title: 'العمليات اليومية',
                  ),
                ),
                Expanded(child: HistoryDay()),
              ],
            ),
          ),
          ShortcutsCard()
        ],
      ),
    );
  }
}
