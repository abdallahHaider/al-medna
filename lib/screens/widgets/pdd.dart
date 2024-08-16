import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

Future<void> generatePdfWeb(
    String name, double cost, String id, String dede, double totleCost) async {
  final pdf = pw.Document();
  final fonddata = await rootBundle.load("assets/fonts/Cairo-Light.ttf");
  final costmfond = pw.Font.ttf(fonddata);
  double size = 315;

  // تحميل صورة من assets
  final ByteData imageData =
      await rootBundle.load('assets/images/invoica.jpeg');
  final Uint8List imageBytes = imageData.buffer.asUint8List();

  final image = pw.MemoryImage(imageBytes);

  // إضافة صفحة جديدة تحتوي على الصورة
  pdf.addPage(
    pw.Page(
      pageTheme: pw.PageTheme(theme: pw.ThemeData.withFont(base: costmfond)),
      build: (pw.Context context) => pw.Center(
          // child: pw.Image(image),
          child: pw.Stack(children: [
        pw.Image(image),
        pw.Positioned(
            right: 70,
            bottom: 155 + size,
            child:
                pw.Text(cost.toString(), textDirection: pw.TextDirection.rtl)),
        pw.Positioned(
            right: 50,
            bottom: 173 + size,
            child: pw.Text(dede, textDirection: pw.TextDirection.rtl)),
        pw.Positioned(
            right: 75,
            bottom: 190 + size,
            child: pw.Text(id, textDirection: pw.TextDirection.rtl)),
        pw.Positioned(
            right: 20,
            bottom: 100 + size,
            child: pw.Text(name, textDirection: pw.TextDirection.rtl)),
        pw.Positioned(
            right: 190,
            bottom: 100 + size,
            child:
                pw.Text(cost.toString(), textDirection: pw.TextDirection.rtl)),
        pw.Positioned(
            right: 250,
            bottom: 100 + size,
            child: pw.Text((totleCost).toString(),
                textDirection: pw.TextDirection.rtl)),
        pw.Positioned(
            right: 340,
            bottom: 100 + size,
            child: pw.Text((totleCost - cost).toString(),
                textDirection: pw.TextDirection.rtl)),
        ///////////////////
        pw.Positioned(
            right: 70,
            bottom: 155,
            child:
                pw.Text(cost.toString(), textDirection: pw.TextDirection.rtl)),
        pw.Positioned(
            right: 50,
            bottom: 173,
            child: pw.Text(dede, textDirection: pw.TextDirection.rtl)),
        pw.Positioned(
            right: 75,
            bottom: 190,
            child: pw.Text(id, textDirection: pw.TextDirection.rtl)),
        pw.Positioned(
            right: 20,
            bottom: 100,
            child: pw.Text(name, textDirection: pw.TextDirection.rtl)),
        pw.Positioned(
            right: 190,
            bottom: 100,
            child:
                pw.Text(cost.toString(), textDirection: pw.TextDirection.rtl)),
        pw.Positioned(
            right: 250,
            bottom: 100,
            child: pw.Text((totleCost).toString(),
                textDirection: pw.TextDirection.rtl)),
        pw.Positioned(
            right: 340,
            bottom: 100,
            child: pw.Text((totleCost - cost).toString(),
                textDirection: pw.TextDirection.rtl)),
      ])),
    ),
  );

  // // حفظ ملف PDF على الويب
  // final bytes = await pdf.save();
  // final blob = html.Blob([bytes], 'application/pdf');
  // final url = html.Url.createObjectUrlFromBlob(blob);
  // final anchor = html.AnchorElement(href: url)
  //   ..setAttribute("download", "example.pdf")
  //   ..click();
  // html.Url.revokeObjectUrl(url);

  // حفظ ملف PDF في جهازك
  final output = await getTemporaryDirectory();
  final file = File("${output.path}/$name.pdf");
  await file.writeAsBytes(await pdf.save());

  print("PDF تم إنشاؤه وحفظه بنجاح في ${file.path}");

  // فتح ملف PDF باستخدام تطبيق خارجي
  await OpenFilex.open(file.path);
}
