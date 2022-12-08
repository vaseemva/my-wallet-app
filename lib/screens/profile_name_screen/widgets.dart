import 'package:flutter/material.dart';
import 'package:my_wallet_app/screens/introduction_screen/indroduction_screen.dart';

Widget logoImage() {
  return Container(
    decoration: BoxDecoration(
        color: Colors.white70, borderRadius: BorderRadius.circular(18.0)),
    padding: const EdgeInsets.all(10.0),
    child: Image.asset(
      appLogoPath,
      height: 80.0,
      width: 80.0,
    ),
  );
}
