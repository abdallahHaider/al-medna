import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

// class InvoicePDF extends flutter.StatefulWidget {
//   const InvoicePDF({flutter.Key? key}) : super(key: key);

//   @override
//   flutter.State<InvoicePDF> createState() => _InvoicePDFState();
// }

// class _InvoicePDFState extends flutter.State<InvoicePDF> {
//   @override
//   flutter.Widget build(flutter.BuildContext context) {
//     return flutter.Scaffold(
//       appBar: flutter.AppBar(
//         title: const flutter.Text('إنشاء فاتورة PDF'),
//       ),
//       body: flutter.Center(
//         child: flutter.ElevatedButton(
//           onPressed: () async {
//             final pdf = await generateInvoice();
//             await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
//           },
//           child: const flutter.Text('إنشاء PDF'),
//         ),
//       ),
//     );
//   }
// }

Future<pw.Document> generateInvoice() async {
  final pdf = pw.Document();
  final logo =
      (await rootBundle.load('assets/images/logo.png')).buffer.asUint8List();

  //  final pdf = pw.Document();
  final fonddata = await rootBundle.load("assets/fonts/Cairo-Light.ttf");
  final costmfond = pw.Font.ttf(fonddata);

  pdf.addPage(
    pw.Page(
      pageTheme: pw.PageTheme(
        theme: pw.ThemeData.withFont(base: costmfond),
        // margin: pw.EdgeInsets.all(10),
        // pageFormat: PdfPageFormat.a4
      ),
      // margin: const pw.EdgeInsets.all(16),
      build: (context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // الشعار والعنوان
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Image(pw.MemoryImage(logo), width: 80, height: 80),
                pw.Text(
                  'فاتورة\nشركة المدينة المنورة العالمية',
                  textDirection: pw.TextDirection.rtl,
                  style: pw.TextStyle(
                    fontSize: 24,
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 20),
            pw.Divider(),

            // معلومات العميل
            pw.Text(
              'استلمت من السيد/ة:',
              style: pw.TextStyle(fontSize: 16),
              textDirection: pw.TextDirection.rtl,
            ),
            pw.SizedBox(height: 10),
            pw.Text(
              'رقم حجز:',
              style: pw.TextStyle(fontSize: 14),
              textDirection: pw.TextDirection.rtl,
            ),
            pw.SizedBox(height: 10),
            pw.Text(
              'رقم الجوال:',
              style: pw.TextStyle(fontSize: 14),
              textDirection: pw.TextDirection.rtl,
            ),
            // pw.Column(
            //   crossAxisAlignment: pw.,
            //   children: [

            //   ],
            // ),
            pw.SizedBox(height: 20),

            // جدول البيانات
            pw.Table(
              border: pw.TableBorder.all(),
              children: [
                pw.TableRow(
                  decoration: const pw.BoxDecoration(color: PdfColors.grey300),
                  children: [
                    pw.Text(
                      'اسم الفندق',
                      textAlign: pw.TextAlign.center,
                      textDirection: pw.TextDirection.rtl,
                    ),
                    pw.Text(
                      'عدد الغرف',
                      textAlign: pw.TextAlign.center,
                      textDirection: pw.TextDirection.rtl,
                    ),
                    pw.Text(
                      'عدد الليالي',
                      textAlign: pw.TextAlign.center,
                      textDirection: pw.TextDirection.rtl,
                    ),
                    pw.Text(
                      'سعر الغرفة',
                      textAlign: pw.TextAlign.center,
                      textDirection: pw.TextDirection.rtl,
                    ),
                    pw.Text(
                      'المجموع',
                      textAlign: pw.TextAlign.center,
                      textDirection: pw.TextDirection.rtl,
                    ),
                    pw.Text(
                      'تاريخ الحجز',
                      textAlign: pw.TextAlign.center,
                      textDirection: pw.TextDirection.rtl,
                    ),
                  ],
                ),
                // إضافة صفوف البيانات (يمكنك استبدالها ببيانات حقيقية)
                pw.TableRow(
                  children: List.generate(
                    6,
                    (index) => pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Text(
                        'بيانات',
                        textDirection: pw.TextDirection.rtl,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 20),

            // الإجمالي الفرعي والمجموع
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.end,
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Text(
                      'الإجمالي الفرعي: 0',
                      textDirection: pw.TextDirection.rtl,
                    ),
                    pw.Text(
                      'المجموع: 0',
                      style: pw.TextStyle(),
                      textDirection: pw.TextDirection.rtl,
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    ),
  );

  return pdf;
}
