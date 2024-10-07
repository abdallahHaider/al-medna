import 'package:admin/controllers/accounts_controller.dart';
import 'package:admin/controllers/action_bank_controller.dart';
import 'package:admin/controllers/action_controller.dart';
import 'package:admin/controllers/authority_controller.dart';
import 'package:admin/controllers/budget_controller.dart';
import 'package:admin/controllers/company_controller.dart';
import 'package:admin/controllers/general_information.dart';
import 'package:admin/controllers/menu_app_controller.dart';
import 'package:admin/controllers/mony_send.dart';
import 'package:admin/controllers/seller_controller.dart';
import 'package:admin/controllers/transactions.dart';
import 'package:admin/controllers/trap_pay_controller.dart';
import 'package:admin/controllers/wallet_provider.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:admin/utl/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';
import 'controllers/hotel_controller.dart';
import 'controllers/reseller_controller.dart';
import 'controllers/rootWidget.dart';
import 'controllers/trap_controller .dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MenuAppController(),
        ),
        ChangeNotifierProvider(
          create: (context) => Rootwidget(),
        ),
        ChangeNotifierProvider(
          create: (context) => ResellerController()..getFetchData(),
        ),
        ChangeNotifierProvider(
          create: (context) => ActionController(),
        ),
        ChangeNotifierProvider(
          create: (context) => HotelController(),
        ),
        ChangeNotifierProvider(
          create: (context) => GeneralInformationController(),
        ),
        ChangeNotifierProvider(
          create: (context) => TrapController(),
        ),
        ChangeNotifierProvider(
          create: (context) => TrapPayController(),
        ),
        ChangeNotifierProvider(
          create: (context) => WalletProvider()..getWallet(false),
        ),
        ChangeNotifierProvider(
          create: (context) => AccountsController(),
        ),
        ChangeNotifierProvider(
          create: (context) => ActionBankController(),
        ),
        ChangeNotifierProvider(
          create: (context) => TransactionsController(),
        ),
        ChangeNotifierProvider(
          create: (context) => CompanyController(),
        ),
        ChangeNotifierProvider(
          create: (context) => MonySend(),
        ),
        ChangeNotifierProvider(
          create: (context) => BudgetController(),
        ),
        ChangeNotifierProvider(
          create: (context) => SellerController(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthorityController(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: true,
        title: 'شركة المدينة المنورة',
        theme: ThemeData(
            primaryColor: primaryColor,
            fontFamily: 'Alexandria',
            brightness: Brightness.light,
            scaffoldBackgroundColor: Color.fromRGBO(246, 251, 255, 1),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(EbuttonColor),
                    foregroundColor: WidgetStateProperty.all(Colors.black87),
                    side: WidgetStateProperty.all(
                        BorderSide(color: Colors.green))))),
        home: Directionality(
          textDirection: TextDirection.rtl,
          child: MainScreen(),
        ),
        navigatorObservers: [FlutterSmartDialog.observer],
        builder: FlutterSmartDialog.init(),
      ),
    );
  }
}
