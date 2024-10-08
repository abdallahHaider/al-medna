import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
// import 'package:universal_html/html.dart';

Future<void> generatePdfWeb(
    String name, String cost, String id, String date, String totalCost) async {
  final pdf = pw.Document();

  // تحميل الخط من assets
  final fonddata = await rootBundle.load("assets/fonts/Cairo-Light.ttf");
  final costmfond = pw.Font.ttf(fonddata);
  double size = 425;

  // تحميل صورة من assets
  final ByteData imageData =
      await rootBundle.load('assets/images/invoica.jpeg');
  final Uint8List imageBytes = imageData.buffer.asUint8List();
  final image = pw.MemoryImage(imageBytes);

  // إضافة صفحة جديدة تحتوي على الصورة وتنسيقها على حجم A4 مع تقليص الحواف
  pdf.addPage(
    pw.Page(
      pageTheme: pw.PageTheme(
        pageFormat: PdfPageFormat.a4.copyWith(
          marginLeft: 5, // تحديد الهوامش حسب الرغبة
          marginRight: 5,
          marginTop: 5,
          marginBottom: 5,
        ),
        theme: pw.ThemeData.withFont(base: costmfond),
      ),
      build: (pw.Context context) => pw.Stack(
        children: [
          // تنسيق الصورة لتناسب حجم الصفحة A4
          pw.Container(
            width: PdfPageFormat.a4.width - 10, // ضبط العرض بعد تقليل الحواف
            height:
                PdfPageFormat.a4.height - 10, // ضبط الارتفاع بعد تقليل الحواف
            child: pw.Image(image, fit: pw.BoxFit.cover),
          ),

          // إضافة العناصر والنصوص بنفس المواضع الأصلية
          pw.Positioned(
              right: 90,
              bottom: 170 + size,
              child: pw.Text(cost.toString(),
                  textDirection: pw.TextDirection.rtl)),
          pw.Positioned(
              right: 70,
              bottom: 190 + size,
              child: pw.Text(date, textDirection: pw.TextDirection.rtl)),
          pw.Positioned(
              right: 95,
              bottom: 210 + size,
              child: pw.Text(id, textDirection: pw.TextDirection.rtl)),
          pw.Positioned(
              right: 20,
              bottom: 100 + size,
              child: pw.Text(name, textDirection: pw.TextDirection.rtl)),
          pw.Positioned(
              right: 160,
              bottom: 100 + size,
              child: pw.Text(cost.toString(),
                  textDirection: pw.TextDirection.rtl)),
          pw.Positioned(
              right: 300,
              bottom: 100 + size,
              child: pw.Text(
                  (double.parse(totalCost) + double.parse(cost)).toString(),
                  textDirection: pw.TextDirection.rtl)),
          pw.Positioned(
              right: 400,
              bottom: 100 + size,
              child:
                  pw.Text("-$totalCost", textDirection: pw.TextDirection.rtl)),

          ///////////////////
          pw.Positioned(
              right: 90,
              bottom: 208,
              child: pw.Text(cost.toString(),
                  textDirection: pw.TextDirection.rtl)),
          pw.Positioned(
              right: 70,
              bottom: 228,
              child: pw.Text(date, textDirection: pw.TextDirection.rtl)),
          pw.Positioned(
              right: 95,
              bottom: 248,
              child: pw.Text(id, textDirection: pw.TextDirection.rtl)),
          pw.Positioned(
              right: 20,
              bottom: 110,
              child: pw.Text(name, textDirection: pw.TextDirection.rtl)),
          pw.Positioned(
              right: 160,
              bottom: 110,
              child: pw.Text(cost.toString(),
                  textDirection: pw.TextDirection.rtl)),
          pw.Positioned(
              right: 300,
              bottom: 110,
              child: pw.Text(
                  (double.parse(totalCost) + double.parse(cost)).toString(),
                  textDirection: pw.TextDirection.rtl)),
          pw.Positioned(
              right: 400,
              bottom: 110,
              child:
                  pw.Text("-$totalCost", textDirection: pw.TextDirection.rtl)),
        ],
      ),
    ),
  );

  // حفظ ملف PDF في جهازك
  final output = await getTemporaryDirectory();
  final file =
      File("${output.path}/${name + DateTime.now().second.toString()}.pdf");
  await file.writeAsBytes(await pdf.save());

  print("PDF تم إنشاؤه وحفظه بنجاح في ${file.path}");

  // فتح ملف PDF باستخدام تطبيق خارجي
  await OpenFilex.open(file.path);

  // // حفظ ملف PDF على الويب
  // final bytes = await pdf.save();
  // final blob = Blob([bytes], 'application/pdf');
  // final url = Url.createObjectUrlFromBlob(blob);
  // final anchor = AnchorElement(href: url)
  //   ..setAttribute("download", "example.pdf")
  //   ..click();
  // Url.revokeObjectUrl(url);
}
