import 'package:flutter/material.dart';

import '../../colors/colors.dart';

Widget sympolContainer(IconData icon) {
  return Container(
      decoration: BoxDecoration(
          color: appThemeColor, borderRadius: BorderRadius.circular(16.0)),
      padding: const EdgeInsets.all(12.0),
      child: Icon(
        icon,
        color: Colors.white,
      ));
}
