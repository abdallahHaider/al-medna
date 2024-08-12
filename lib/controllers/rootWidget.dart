import 'package:flutter/material.dart';

import '../screens/dashboard/dashboard_screen.dart';

class Rootwidget extends ChangeNotifier{

  Widget mywidget=DashboardScreen();

  void getWidet(Widget widget){
    mywidget=widget ;
    notifyListeners();
  }
}
