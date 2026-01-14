import 'dart:io';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

Future<File> generateReceiptPdf() async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text("OnCampus", style: pw.TextStyle(fontSize: 24)),
            pw.SizedBox(height: 10),

            pw.Text("Payment Confirmed", style: pw.TextStyle(fontSize: 18)),
            pw.Divider(),

            pw.Text("Student: Kwame Mensah"),
            pw.Text("Email: kwame.m@uni.edu.gh"),
            pw.SizedBox(height: 10),

            pw.Text("Hostel: Nana Hostels"),
            pw.Text("Room: Executive (2-in-room)"),
            pw.Text("Block: B, Room 104"),
            pw.SizedBox(height: 10),

            pw.Text("Stay: Sep 15, 2023 - May 15, 2024"),
            pw.SizedBox(height: 10),

            pw.Divider(),
            pw.Text("Room Payment: GHS 5000"),
            pw.Text("Processing Fee: GHS 50"),
            pw.Text("VAT: GHS 0"),
            pw.Divider(),
            pw.Text("Total: GHS 5050",
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),

            pw.SizedBox(height: 20),
            pw.Text("Transaction ID: #GH-TRX-8829304"),
          ],
        );
      },
    ),
  );

  final dir = await getApplicationDocumentsDirectory();
  final file = File("${dir.path}/receipt.pdf");

  await file.writeAsBytes(await pdf.save());
  return file;
}
