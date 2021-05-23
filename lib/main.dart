import "package:flutter/material.dart";
import 'package:flutter_catalog/pages/home_page.dart';
import 'package:flutter_catalog/pages/login_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        color: Colors.white,
        themeMode: ThemeMode.light,
        darkTheme: ThemeData.dark(),
        theme: ThemeData(fontFamily: GoogleFonts.lato().fontFamily),
        routes: {
          "/": (context) => LoginPage(),
          "login": (context) => LoginPage()
        });
  }
}
