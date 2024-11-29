import 'package:admin/controllers/rootWidget.dart';
import 'package:admin/screens/authority/authority_page.dart';
import 'package:admin/screens/budget/budget_page.dart';
import 'package:admin/screens/campany/campany_page.dart';
import 'package:admin/screens/hotel/hotel_page.dart';
import 'package:admin/screens/reseller/reseller_page.dart';
import 'package:admin/screens/trap/trap_page.dart';
import 'package:admin/utl/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShortcutsCard extends StatelessWidget {
  const ShortcutsCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: blueColor,
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShortCardWidget(
                onPressed: () => Provider.of<Rootwidget>(context, listen: false)
                    .getWidet(BudgetPage()),
                title: "الميزانية",
                icon: Icons.balance,
              ),
              SizedBox(height: defaultPadding),
              ShortCardWidget(
                onPressed: () => Provider.of<Rootwidget>(context, listen: false)
                    .getWidet(ResellerPage()),
                title: "الوكلاء",
                icon: Icons.person,
              ),
              SizedBox(height: defaultPadding),
              ShortCardWidget(
                onPressed: () => Provider.of<Rootwidget>(context, listen: false)
                    .getWidet(TrapPage()),
                title: "الرحلات",
                icon: Icons.airplanemode_on,
              ),
              SizedBox(height: defaultPadding),
              ShortCardWidget(
                onPressed: () => Provider.of<Rootwidget>(context, listen: false)
                    .getWidet(AuthorityPage()),
                title: "الحسابات العامه",
                icon: Icons.manage_accounts,
              ),
              SizedBox(height: defaultPadding),
              ShortCardWidget(
                onPressed: () => Provider.of<Rootwidget>(context, listen: false)
                    .getWidet(HotelPage()),
                title: "الفنادق",
                icon: Icons.hotel,
              ),
              SizedBox(height: defaultPadding),
              ShortCardWidget(
                onPressed: () => Provider.of<Rootwidget>(context, listen: false)
                    .getWidet(CampanyPage()),
                title: "الشركات",
                icon: Icons.holiday_village_sharp,
              ),
              SizedBox(height: defaultPadding),
            ],
          ),
        ),
      ),
    );
  }
}

class ShortCardWidget extends StatelessWidget {
  const ShortCardWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onPressed,
  });

  final String title;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: blueColor,
          border: Border.all(color: Colors.grey, width: 3),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(0, 7), // changes position of shadow
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                    child: Icon(
                  icon,
                  size: 100,
                  color: Colors.grey.shade400,
                )),
                Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        color: primaryColor),
                    child: Center(child: Text(title))),
              ],
            ),
            Positioned(
                bottom: 25,
                left: 20,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.arrow_outward),
                ))
          ],
        ),
      ),
    );
  }
}
