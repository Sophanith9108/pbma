import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static final TextStyle header = GoogleFonts.angkor(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  static final TextStyle header1 = GoogleFonts.angkor(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  static final TextStyle header2 = GoogleFonts.angkor(
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle title = GoogleFonts.battambang(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  static final TextStyle title1 = GoogleFonts.battambang(
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );
  static final TextStyle subtitle = GoogleFonts.battambang(fontSize: 14);
  static final TextStyle ssubtitle = GoogleFonts.ubuntuMono(fontSize: 12);

  static final TextStyle label = GoogleFonts.battambang(fontSize: 16);
  static final TextStyle value = GoogleFonts.battambang(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle hint = GoogleFonts.battambang(fontSize: 14);

  static final TextStyle button = GoogleFonts.battambang(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle caption = GoogleFonts.battambang(
    fontSize: 12,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle error = GoogleFonts.battambang(
    fontSize: 12,
    color: Colors.red,
  );
  static final TextStyle link = GoogleFonts.battambang(
    fontSize: 14,
    color: Colors.blue,
    fontWeight: FontWeight.bold,
  );
  static final TextStyle disabled = GoogleFonts.battambang(
    fontSize: 14,
    color: Colors.grey,
  );

  static final TextStyle text = GoogleFonts.battambang(fontSize: 16);

  static final TextStyle amount = GoogleFonts.battambang(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.green,
  );
  static final TextStyle amountNegative = GoogleFonts.battambang(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.red,
  );
  static final TextStyle amountNeutral = GoogleFonts.battambang(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.grey,
  );

  static final amountPositive = GoogleFonts.battambang(
    fontSize: 26,
    fontWeight: FontWeight.bold,
    color: Colors.green,
  );

  static final amountLeft = GoogleFonts.battambang(
    fontSize: 26,
    fontWeight: FontWeight.bold,
    color: Colors.redAccent,
  );

  static final note = GoogleFonts.battambang(fontSize: 14, color: Colors.grey);

  static final TextStyle balance = GoogleFonts.battambang(
    fontSize: 26,
    color: Colors.blue.shade900,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle budget = GoogleFonts.battambang(
    fontSize: 26,
    color: Colors.deepPurple.shade900,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle expense = GoogleFonts.battambang(
    fontSize: 26,
    color: Colors.red.shade900,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle income = GoogleFonts.battambang(
    fontSize: 26,
    color: Colors.green.shade900,
    fontWeight: FontWeight.bold,
  );
}
