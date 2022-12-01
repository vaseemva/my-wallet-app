import 'package:flutter/material.dart';

Widget noGraph() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        'assets/images/99500-company-statistic-graph.json',
        height: 350,
      ),
      const Text(
        "Not enough data to render chart",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ],
  );
}
