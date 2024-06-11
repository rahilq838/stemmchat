import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants.dart';

bool isValidEmail(String email) {
  const pattern = r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\.[a-zA-Z]{2,}$";
  final regExp = RegExp(pattern);
  return regExp.hasMatch(email);
}

bool isValidPassword(String password) {
  const pattern = r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$";
  final regExp = RegExp(pattern);
  return regExp.hasMatch(password);
}

String? emailValidator(String? text) {
  if (text == null || text.isEmpty) {
    return "Field can't be empty";
  }
  if (!isValidEmail(text)) {
    return "Invalid Email";
  }
  return null;
}


TextStyle getTextStyle({fs, fw, fc, decor}) {
  return TextStyle(
    fontSize: fs != null ? fs.toDouble() : 14,
    fontWeight: fw ?? FontWeight.w400,
    fontFamily: GoogleFonts.poppins().fontFamily,
    color: fc ?? Colors.black,
    decoration: decor ?? TextDecoration.none,
  );
}

InputDecoration getInputDecoration({labelText, border, suffixIcon}) {
  return InputDecoration(
    labelText: labelText ?? "",
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: focusColor),
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
    // focusColor: focusColor,
    labelStyle: getTextStyle(fs: 16, fw: FontWeight.w500),
    border: border ??
        const OutlineInputBorder(
          borderSide: BorderSide(color: focusColor, width: 10),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
    suffixIcon: suffixIcon,
  );
}

EdgeInsets getLRTBPadding({left, right, top, bottom}) {
  return EdgeInsets.only(
      left: left ?? 30,
      right: right ?? 30,
      top: top ?? 10,
      bottom: bottom ?? 10);
}

ButtonStyle getElevatedButtonStyle({color,radius}) {
 return  ElevatedButton.styleFrom(
    elevation: 10,
    backgroundColor: color ?? focusColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius??12.0),
    ),
  );
}
