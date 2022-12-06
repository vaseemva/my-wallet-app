import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:my_wallet_app/colors/colors.dart';
import 'package:my_wallet_app/controllers/db_helper.dart';
import 'package:my_wallet_app/models/transaction_model.dart';
import 'package:my_wallet_app/screens/home%20screens/widgets.dart';

import 'package:my_wallet_app/screens/indroduction_screen.dart';
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

  List<FlSpot> dataSet = [];
  List<FlSpot> getPlotPoints(List<TransactionModel> entireData) {
    dataSet = [];
    List tempdataSet = [];

    for (TransactionModel item in entireData) {
      if (item.dateTime.month == today.month && item.type == "expense") {
        tempdataSet.add(item);
      }
    }
    //
    // Sorting the list as per the date
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
    getpreferences();
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
                  Row(
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
                        "${preferences.getString('name')}'s Wallet",
                        style: const TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.w300),
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    margin: const EdgeInsets.all(12.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: appThemeColor,
                          borderRadius: BorderRadius.circular(18.0)),
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Column(
                        children: [
                          const Text(
                            'Total Balance',
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(fontSize: 22.0, color: Colors.white),
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          Text(
                            ' ₹ $totalBalance',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 28.0,
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
                  ),

                  const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      'Expenses',
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500),
                    ),
                  ),

                  dataSet.length < 2
                      ? const SizedBox(
                          height: 150.0,
                          child: Center(
                              child:
                                  Text('Not enough datas to render chart..!')))
                      : walletLineChart(getPlotPoints(snapshot.data!)),

                  const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      'Recent Transactions',
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  //
                  //
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
