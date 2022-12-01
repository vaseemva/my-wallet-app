import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:my_wallet_app/screens/graph_screen/widgets.dart';

import '../../colors/colors.dart';
import '../../controllers/db_helper.dart';
import '../../models/transaction_model.dart';

class Graphscreen extends StatefulWidget {
  const Graphscreen({Key? key}) : super(key: key);

  @override
  State<Graphscreen> createState() => _GraphscreenState();
}

class _GraphscreenState extends State<Graphscreen> {
  Dbhelper dbhelper = Dbhelper();

  late Box box;
  Future<List<TransactionModel>> fetch() async {
    if (box.values.isEmpty) {
      return Future.value([]);
    } else {
      List<TransactionModel> items = [];
      box.toMap().values.forEach((element) {
        items.add(TransactionModel(
            element['amount'] as int,
            element['dateTime'] as DateTime,
            element['type'],
            element['note'],
            element['date']));
      });
      return items;
    }
  }

  @override
  void initState() {
    super.initState();
    box = Hive.box('transactions');
    fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
        backgroundColor: appThemeColor,
      ),
      body: FutureBuilder<List<TransactionModel>>(
          future: fetch(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text("Unexpected Error Occured !!"));
            }
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return Center(child: noGraph());
              }

              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      'Graphical Analysis',
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: 400.0,
                    child: LineChart(
                      LineChartData(lineBarsData: [
                        LineChartBarData(spots: [
                          const FlSpot(8, 8),
                          const FlSpot(13, 15),
                          const FlSpot(5, 12),
                        ], isCurved: false, color: appThemeColor, barWidth: 2.5)
                      ]),
                    ),
                  ),
                ],
              ));
            } else {
              return const Center(
                child: Text("Unexpected Error Occured !!"),
              );
            }
          }),
    );
  }
}
