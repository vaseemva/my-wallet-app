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
          "Not enough data to render chart",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}

Widget dropDownContainer(BuildContext context, {child}) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.40,
    height: MediaQuery.of(context).size.height * 0.06,
    decoration: BoxDecoration(
      color: appThemeColor,
      borderRadius: BorderRadius.circular(20),
    ),
    child: child,
  );
}

class NovemberWalletPieChart extends StatefulWidget {
  const NovemberWalletPieChart({
    super.key,
    required this.dataList,
  });
  final List<TransactionModel> dataList;

  @override
  State<NovemberWalletPieChart> createState() => _NovemberWalletPieChartState();
}

class _NovemberWalletPieChartState extends State<NovemberWalletPieChart> {
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

  @override
  void initState() {
    getTotalBalance(widget.dataList);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.dataList.isEmpty) {
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
              chartRadius: 280,
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
}

class DecemberWalletPieChart extends StatefulWidget {
  const DecemberWalletPieChart({
    super.key,
    required this.dataList,
  });
  final List<TransactionModel> dataList;

  @override
  State<DecemberWalletPieChart> createState() => _DecemberWalletPieChartState();
}

class _DecemberWalletPieChartState extends State<DecemberWalletPieChart> {
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

  @override
  void initState() {
    getTotalBalance(widget.dataList);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.dataList.isEmpty) {
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
              chartRadius: 280,
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
}

class JanuaryWalletPieChart extends StatefulWidget {
  const JanuaryWalletPieChart({
    super.key,
    required this.dataList,
  });
  final List<TransactionModel> dataList;

  @override
  State<JanuaryWalletPieChart> createState() => _JanuaryWalletPieChartState();
}

class _JanuaryWalletPieChartState extends State<JanuaryWalletPieChart> {
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

  @override
  void initState() {
    getTotalBalance(widget.dataList);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.dataList.isEmpty) {
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
              chartRadius: 280,
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
}

class FebruaryWalletPieChart extends StatefulWidget {
  const FebruaryWalletPieChart({
    super.key,
    required this.dataList,
  });
  final List<TransactionModel> dataList;

  @override
  State<FebruaryWalletPieChart> createState() => _FebruaryWalletPieChartState();
}

class _FebruaryWalletPieChartState extends State<FebruaryWalletPieChart> {
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

  @override
  void initState() {
    getTotalBalance(widget.dataList);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.dataList.isEmpty) {
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
              chartRadius: 280,
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
}

class MarchWalletPieChart extends StatefulWidget {
  const MarchWalletPieChart({
    super.key,
    required this.dataList,
  });
  final List<TransactionModel> dataList;

  @override
  State<MarchWalletPieChart> createState() => _MarchWalletPieChartState();
}

class _MarchWalletPieChartState extends State<MarchWalletPieChart> {
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

  @override
  void initState() {
    getTotalBalance(widget.dataList);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.dataList.isEmpty) {
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
              chartRadius: 280,
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
}

class AprilWalletPieChart extends StatefulWidget {
  const AprilWalletPieChart({
    super.key,
    required this.dataList,
  });
  final List<TransactionModel> dataList;

  @override
  State<AprilWalletPieChart> createState() => _AprilWalletPieChartState();
}

class _AprilWalletPieChartState extends State<AprilWalletPieChart> {
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

  @override
  void initState() {
    getTotalBalance(widget.dataList);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.dataList.isEmpty) {
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
              chartRadius: 280,
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
}

class MayWalletPieChart extends StatefulWidget {
  const MayWalletPieChart({
    super.key,
    required this.dataList,
  });
  final List<TransactionModel> dataList;

  @override
  State<MayWalletPieChart> createState() => _MayWalletPieChartState();
}

class _MayWalletPieChartState extends State<MayWalletPieChart> {
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

  @override
  void initState() {
    getTotalBalance(widget.dataList);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.dataList.isEmpty) {
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
              chartRadius: 280,
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
}

class JuneWalletPieChart extends StatefulWidget {
  const JuneWalletPieChart({
    super.key,
    required this.dataList,
  });
  final List<TransactionModel> dataList;

  @override
  State<JuneWalletPieChart> createState() => _JuneWalletPieChartState();
}

class _JuneWalletPieChartState extends State<JuneWalletPieChart> {
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

  @override
  void initState() {
    getTotalBalance(widget.dataList);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.dataList.isEmpty) {
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
              chartRadius: 280,
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
}

class JulyWalletPieChart extends StatefulWidget {
  const JulyWalletPieChart({
    super.key,
    required this.dataList,
  });
  final List<TransactionModel> dataList;

  @override
  State<JulyWalletPieChart> createState() => _JulyWalletPieChartState();
}

class _JulyWalletPieChartState extends State<JulyWalletPieChart> {
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

  @override
  void initState() {
    getTotalBalance(widget.dataList);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.dataList.isEmpty) {
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
              chartRadius: 280,
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
}

class AugustWalletPieChart extends StatefulWidget {
  const AugustWalletPieChart({
    super.key,
    required this.dataList,
  });
  final List<TransactionModel> dataList;

  @override
  State<AugustWalletPieChart> createState() => _AugustWalletPieChartState();
}

class _AugustWalletPieChartState extends State<AugustWalletPieChart> {
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

  @override
  void initState() {
    getTotalBalance(widget.dataList);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.dataList.isEmpty) {
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
              chartRadius: 280,
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
}

class SeptemberWalletPieChart extends StatefulWidget {
  const SeptemberWalletPieChart({
    super.key,
    required this.dataList,
  });
  final List<TransactionModel> dataList;

  @override
  State<SeptemberWalletPieChart> createState() =>
      _SeptemberWalletPieChartState();
}

class _SeptemberWalletPieChartState extends State<SeptemberWalletPieChart> {
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

  @override
  void initState() {
    getTotalBalance(widget.dataList);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.dataList.isEmpty) {
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
              chartRadius: 280,
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
}

class OctoberWalletPieChart extends StatefulWidget {
  const OctoberWalletPieChart({
    super.key,
    required this.dataList,
  });
  final List<TransactionModel> dataList;

  @override
  State<OctoberWalletPieChart> createState() => _OctoberWalletPieChartState();
}

class _OctoberWalletPieChartState extends State<OctoberWalletPieChart> {
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

  @override
  void initState() {
    getTotalBalance(widget.dataList);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.dataList.isEmpty) {
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
              chartRadius: 280,
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
}
