import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

Widget noDataHome() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        'assets/images/nodatahome.gif',
        height: 350,
      ),
      const Text(
        "Add a transaction to get started...",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ],
  );
}

Widget walletLineChart(dynamic spots) {
  return Container(
    height: 200.0,
    padding: const EdgeInsets.symmetric(
      vertical: 10.0,
      horizontal: 12.0,
    ),
    margin: const EdgeInsets.all(
      12.0,
    ),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(8),
        topRight: Radius.circular(8),
        bottomLeft: Radius.circular(8),
        bottomRight: Radius.circular(8),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(0, 3), // changes position of shadow
        ),
      ],
    ),
    child: LineChart(
      LineChartData(
        borderData: FlBorderData(
          show: false,
        ),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: false,
            barWidth: 2.5,
            showingIndicators: [200, 200, 90, 10],
            dotData: FlDotData(
              show: true,
            ),
          ),
        ],
      ),
    ),
  );
}
