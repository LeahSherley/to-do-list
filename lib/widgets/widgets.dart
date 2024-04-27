import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget scaffoldtext(String text) {
  return Text(text,
      style: TextStyle(
        fontSize: 15,
        color: Colors.pink[300],
        fontWeight: FontWeight.w600,
      ));
}
Widget mytext(String text) {
  return Text(text,
      style: TextStyle(
        fontSize: 13,
        color: Colors.pink[300],
      ));
}
Widget drawertext(String text) {
  return Text(text,
      style: TextStyle(
        fontSize: 13,
        color: Colors.grey[800],
        fontFamily: GoogleFonts.gentiumPlus().fontFamily,
      ));
}
SnackBar mySnackBar(
  String message,
) {
  return SnackBar(
    elevation: 5.0,
    duration: const Duration(milliseconds: 6000),
    margin: const EdgeInsets.only(right:40, left:40, bottom:20,),
    padding: const EdgeInsets.all(10),
    dismissDirection: DismissDirection.horizontal,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.pink[400],
    content: Text(
      message,
      textAlign: TextAlign.start,
      style:  TextStyle(
        color: Colors.grey[800],
        fontSize: 11,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
Widget heading(String text) {
  return Text(
    text,
    style: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.pink,
    ),
    textAlign: TextAlign.center,
  );
}