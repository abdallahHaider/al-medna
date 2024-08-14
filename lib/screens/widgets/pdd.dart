// import 'dart:io';
// import 'dart:typed_data';
// import 'package:flutter/services.dart' show rootBundle;
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:path_provider/path_provider.dart';
// import 'package:open_filex/open_filex.dart';

// Future<void> generateAndOpenPdf() async {
//   final pdf = pw.Document();

//   // إضافة نص إلى ملف PDF
//   pdf.addPage(
//     pw.Page(
//       build: (pw.Context context) => pw.Center(
//         child: pw.Text("Hello, عمر! هذا نص داخل ملف PDF"),
//       ),
//     ),
//   );

//   // تحميل صورة من assets
//   final ByteData imageData = await rootBundle.load('assets/images/logo.png');
//   final Uint8List imageBytes = imageData.buffer.asUint8List();

//   final image = pw.MemoryImage(imageBytes);

//   // إضافة صفحة جديدة تحتوي على الصورة
//   pdf.addPage(
//     pw.Page(
//       build: (pw.Context context) => pw.Center(
//         child: pw.Image(image),
//       ),
//     ),
//   );

//   // حفظ ملف PDF في جهازك
//   final output = await getTemporaryDirectory();
//   final file = File("${output.path}/example.pdf");
//   await file.writeAsBytes(await pdf.save());

//   print("PDF تم إنشاؤه وحفظه بنجاح في ${file.path}");

//   // فتح ملف PDF باستخدام تطبيق خارجي
//   await OpenFilex.open(file.path);
// }

import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;

Future<void> generatePdfWeb() async {
  final pdf = pw.Document();
  final fonddata=await rootBundle.load("assets/fonts/Arial.ttf");
  final costmfond=pw.Font.ttf(fonddata);
  final fontt = await GoogleFonts.alexandria();

  // // إضافة نص إلى ملف PDF
  // pdf.addPage(
  //   pw.Page(
  //     build: (pw.Context context) => pw.Center(
  //       child: pw.Text("Hello, عمر! هذا نص داخل ملف PDF"),
  //     ),
  //   ),
  // );

  // تحميل صورة من assets
  final ByteData imageData = await rootBundle.load('assets/images/invoica.jpeg');
  final Uint8List imageBytes = imageData.buffer.asUint8List();

  final image = pw.MemoryImage(imageBytes);

  // إضافة صفحة جديدة تحتوي على الصورة
  pdf.addPage(
    pw.Page(
      build: (pw.Context context) => pw.Center(
        // child: pw.Image(image),
        child: pw.Stack(children: [
          pw.Image(image),
          pw.Positioned(right: 50,bottom: 160,child:pw.Text("111")),
          pw.Positioned(right: 55,bottom: 175,child:pw.Text("222")),
          pw.Positioned(right: 55,bottom: 190,child:pw.Text("3333")),
          pw.Positioned(right: 10,bottom: 100,child:pw.Text("احمد نايف")),
           pw.Positioned(right: 100,bottom: 100,child:pw.Text("name")),
            pw.Positioned(right: 300,bottom: 100,child:pw.Text("name")),
             pw.Positioned(right: 400,bottom: 100,child:pw.Text("name")),
        ])
      ),
    ),
  );

  // حفظ ملف PDF على الويب
  final bytes = await pdf.save();
  final blob = html.Blob([bytes], 'application/pdf');
  final url = html.Url.createObjectUrlFromBlob(blob);
  final anchor = html.AnchorElement(href: url)
    ..setAttribute("download", "example.pdf")
    ..click();
  html.Url.revokeObjectUrl(url);
}

// void main() {
//   runApp(MaterialApp(
//     home: Scaffold(
//       appBar: AppBar(title: Text('PDF Example')),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: generatePdfWeb,
//           child: Text('Generate PDF'),
//         ),
//       ),
//     ),
//   ));
// }

