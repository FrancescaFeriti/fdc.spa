import 'package:flutter/material.dart';

Widget traslucedComponent(BuildContext context, IconData icon, String hintText, bool isPassword, bool isEmail) {
  Size size = MediaQuery.of(context).size;
  return Container(
    height: size.width / 8,
    width: size.width / 1.25,
    alignment: Alignment.center,
    padding: EdgeInsets.only(right: size.width / 30),
    decoration: BoxDecoration(
      color: Colors.black.withOpacity(.1),
      borderRadius: BorderRadius.circular(20),
    ),
    child: TextField(
      style: TextStyle(
        color: Colors.white.withOpacity(.9),
      ),
      obscureText: isPassword,
      keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: Colors.white.withOpacity(.8),
        ),
        border: InputBorder.none,
        hintMaxLines: 1,
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 14,
          color: Colors.white.withOpacity(.5),
        ),
      ),
    ),
  );
}
