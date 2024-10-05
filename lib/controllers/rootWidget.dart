import 'package:flutter/material.dart';

import '../screens/dashboard/dashboard_screen.dart';

class Rootwidget extends ChangeNotifier {
  Widget mywidget = DashboardScreen();
  int index = 1;

  void getWidet(Widget widget) {
    mywidget = widget;
    notifyListeners();
  }
}
