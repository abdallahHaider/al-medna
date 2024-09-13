import 'package:admin/screens/hotel/add_sale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:admin/controllers/hotel_controller.dart';
import 'package:admin/controllers/reseller_controller.dart';
import 'package:provider/provider.dart';

void main() {
  group('AddSale widget test', () {
    testWidgets('Test AddSale widget', (WidgetTester tester) async {
      // Create a mock HotelController and ResellerController
      final hotelController = MockHotelController();
      final resellerController = MockResellerController();

      // Pump the AddSale widget with the mock controllers
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => hotelController),
            ChangeNotifierProvider(create: (_) => resellerController),
          ],
          child: MaterialApp(
            home: AddSale(),
          ),
        ),
      );

      // Verify that the AddSale widget is displayed
      expect(find.byType(AddSale), findsOneWidget);

      // Verify that the hotel dropdown is displayed
      expect(find.byType(DropdownButtonFormField), findsNWidgets(2));

      // Verify that the reseller dropdown is displayed
      expect(find.byType(DropdownButtonFormField), findsNWidgets(3));

      // Verify that the table is displayed
      expect(find.byType(Table), findsOneWidget);

      // Verify that the elevated button is displayed
      expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });
}

// Mock HotelController
class MockHotelController extends HotelController {
  @override
  Future<void> getFetchData(bool value) async {}

  // @override
  // Future addSaleHotel (
  //   String hotelID,
  //   String rooms,
  //   String price,
  //   String currency,
  //   String day,
  //   BuildContext context,
  //   String resellerID,
  //   String buyerName,
  // ) async {}
}

// Mock ResellerController
class MockResellerController extends ResellerController {
  // @override
  // Future<List<dynamic>> fetchHotelBuyer() async {}
}
