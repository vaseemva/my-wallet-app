import 'package:flutter/material.dart';
import 'package:my_wallet_app/models/transaction_model.dart';

import 'package:pie_chart/pie_chart.dart';

import '../../colors/colors.dart';

Widget noGraph(BuildContext context) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.75,
    width: MediaQuery.of(context).size.width * 0.7,
    child: Column(
      children: [
        Image.asset(
          'assets/images/nograph.gif',
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width * 0.7,
        ),
        const Text(
          "No data to render chart",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}

Widget dropDownContainer(BuildContext context, {child}) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.30,
    height: MediaQuery.of(context).size.height * 0.06,
    
    decoration: BoxDecoration(
      color: appThemeColor,
      borderRadius: BorderRadius.circular(20),
    ),
    child: child,
  );
}

Widget graphWidget(
    {required List<TransactionModel> dataList, required BuildContext context}) {
  List<TransactionModel> datas = dataList;
  double totalIncome = 0;
  double totalExpense = 0;
  Map<String, double> dataMap = {};
  List<Color> chartColors = [];
  getTotalBalance(List<TransactionModel> entireData) {
    totalIncome = 0;
    totalExpense = 0;

    for (TransactionModel data in entireData) {
      if (entireData.isEmpty) {
        return;
      }
      if (entireData.first.type == 'income') {
        chartColors.add(const Color.fromRGBO(51, 204, 51, 1));
        chartColors.add(const Color.fromRGBO(255, 51, 0, 1));
      } else {
        chartColors.add(const Color.fromRGBO(255, 51, 0, 1));
        chartColors.add(const Color.fromRGBO(51, 204, 51, 1));
      }
      if (data.type == 'income') {
        totalIncome += data.amount;
        dataMap.addAll({"Income": totalIncome});
      } else {
        totalExpense += data.amount;
        dataMap.addAll({'Expense': totalExpense});
      }
    }
  }

  getTotalBalance(dataList);
  if (datas.isEmpty) {
    return Center(child: noGraph(context));
  }
  return Center(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width * 0.9,
          child: PieChart(
            chartRadius: 250,
            legendOptions:
                const LegendOptions(legendPosition: LegendPosition.bottom),
            chartValuesOptions:
                const ChartValuesOptions(showChartValuesInPercentage: true),
            dataMap: dataMap,
            colorList: chartColors,
            chartType: ChartType.ring,
            ringStrokeWidth: 50.0,
          )),
    ],
  ));
}

Widget statisticsText(BuildContext context) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.1,
    child: const Center(
      child: Text(
        'Statistics',
        style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
      ),
    ),
  );
}
