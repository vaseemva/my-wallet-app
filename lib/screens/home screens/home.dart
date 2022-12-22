import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:my_wallet_app/colors/colors.dart';
import 'package:my_wallet_app/controllers/db_helper.dart';
import 'package:my_wallet_app/models/transaction_model.dart';
import 'package:my_wallet_app/screens/home%20screens/widgets.dart';
import 'package:my_wallet_app/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Dbhelper dbhelper = Dbhelper();
  DateTime today = DateTime.now();
  late SharedPreferences preferences;
  late Box box;
  int totalBalance = 0;
  int totalIncome = 0;
  int totalExpense = 0;
  getpreferences() async {
    preferences = await SharedPreferences.getInstance();
  }

  String? name;
  List<FlSpot> dataSet = [];
  List<FlSpot> getPlotPoints(List<TransactionModel> entireData) {
    dataSet = [];
    List tempdataSet = [];

    for (TransactionModel item in entireData) {
      if (item.dateTime.month == today.month && item.type == "expense") {
        tempdataSet.add(item);
      }
    }

    tempdataSet.sort((a, b) => a.dateTime.day.compareTo(b.dateTime.day));
    //
    for (var i = 0; i < tempdataSet.length; i++) {
      dataSet.add(
        FlSpot(
          tempdataSet[i].dateTime.day.toDouble(),
          tempdataSet[i].amount.toDouble(),
        ),
      );
    }
    return dataSet;
  }

  getTotalBalance(List<TransactionModel> entireData) {
    totalBalance = 0;
    totalIncome = 0;
    totalExpense = 0;

    for (TransactionModel data in entireData) {
      if (data.dateTime.month == today.month) {
        if (data.type == 'income') {
          totalBalance += data.amount;
          totalIncome += data.amount;
        } else {
          totalBalance -= data.amount;
          totalExpense += data.amount;
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getpreferences();

    box = Hive.box('transactions');
    dbhelper.fetchSavedData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0.0,
        backgroundColor: appThemeColor,
      ),
      body: FutureBuilder<List<TransactionModel>>(
          future: dbhelper.fetchSavedData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(child: SizedBox());
            }
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return Center(child: noDataHome());
              }

              getTotalBalance(snapshot.data!);
              getPlotPoints(snapshot.data!);
              return ListView(
                padding: const EdgeInsets.all(12.0),
                children: [
                  nameCard(name: "${preferences.getString('name')}"),
                  homeWalletCard(
                      context: context,
                      totalBalance: totalBalance,
                      totalIncome: totalIncome,
                      totalExpense: totalExpense),
                  expenseText(),
                  dataSet.length < 2
                      ? const SizedBox(
                          height: 150.0,
                          child: Center(
                              child:
                                  Text('Not enough data to render chart..!')))
                      : walletLineChart(getPlotPoints(snapshot.data!)),
                  recentText(),
                  ListView.builder(
                      shrinkWrap: true,
                      reverse: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        TransactionModel dataAtIndex = snapshot.data![index];

                        if (dataAtIndex.type == 'income') {
                          return incomeTile(dataAtIndex.amount,
                              dataAtIndex.note, dataAtIndex.date.toString());
                        } else {
                          return expenseTile(dataAtIndex.amount,
                              dataAtIndex.note, dataAtIndex.date.toString());
                        }
                      })
                ],
              );
            } else {
              return const Center(
                child: SizedBox(),
              );
            }
          }),
    );
  }
}
