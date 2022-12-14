import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:my_wallet_app/colors/colors.dart';

import '../../widgets/widgets.dart';
import '../introduction_screen/indroduction_screen.dart';

Widget nameCard({required String name}) {
  return Row(
    children: [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          color: Colors.white70,
        ),
        padding: const EdgeInsets.all(2.0),
        child: Image.asset(
          appLogoPath,
          width: 50.0,
          height: 50.0,
        ),
      ),
      const SizedBox(
        width: 12.0,
      ),
      Text(
        "$name's Wallet",
        style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300),
        overflow: TextOverflow.ellipsis,
      )
    ],
  );
}

Widget homeWalletCard(
    {required BuildContext context,
    required int totalBalance,
    required int totalIncome,
    required int totalExpense}) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.9,
    margin: const EdgeInsets.all(12.0),
    child: Container(
      decoration: BoxDecoration(
          color: appThemeColor, borderRadius: BorderRadius.circular(18.0)),
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        children: [
          const Text(
            'Total Balance',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22.0, color: Colors.white),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 12.0,
          ),
          Text(
            ' ₹ $totalBalance',
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 32.0,
                color: Colors.white,
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 12.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                incomeCard(totalIncome.toString()),
                expenseCard(totalExpense.toString())
              ],
            ),
          )
        ],
      ),
    ),
  );
}

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

Widget expenseText() {
  return const Padding(
    padding: EdgeInsets.all(12.0),
    child: Text(
      'Expenses',
      style: TextStyle(
          fontSize: 20.0, color: Colors.black87, fontWeight: FontWeight.w500),
    ),
  );
}

Widget recentText() {
  return const Padding(
    padding: EdgeInsets.all(12.0),
    child: Text(
      'Recent Transactions',
      style: TextStyle(
          fontSize: 20.0, color: Colors.black87, fontWeight: FontWeight.w500),
    ),
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
