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

String graphFilterValue = "All";
String monthsFilterValue = "January";
bool _isvisible = false;

class _GraphscreenState extends State<Graphscreen> {
  Dbhelper dbhelper = Dbhelper();

  double totalIncome = 0;
  double totalExpense = 0;
  final graphFilter = <String>[
    'All',
    'Monthly',
  ];
  final monthsFilter = <String>[
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  Map<String, double> dataMap = {};

  getTotalBalance(List<TransactionModel> entireData) {
    totalIncome = 0;
    totalExpense = 0;

    for (TransactionModel data in entireData) {
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

  List<TransactionModel> januaryList = [];
  List<TransactionModel> februaryList = [];
  List<TransactionModel> marchList = [];
  List<TransactionModel> aprilList = [];
  List<TransactionModel> mayList = [];
  List<TransactionModel> juneList = [];
  List<TransactionModel> julyList = [];
  List<TransactionModel> augustList = [];
  List<TransactionModel> septemberList = [];
  List<TransactionModel> octoberList = [];
  List<TransactionModel> novemberList = [];
  List<TransactionModel> decemberList = [];

  List<Color> chartColors = [];
  getMonthsList(List<TransactionModel> list) {
    for (TransactionModel item in list) {
      if (item.dateTime.month == 1) {
        januaryList.add(item);
      } else if (item.dateTime.month == 2) {
        februaryList.add(item);
      } else if (item.dateTime.month == 3) {
        marchList.add(item);
      } else if (item.dateTime.month == 4) {
        aprilList.add(item);
      } else if (item.dateTime.month == 5) {
        mayList.add(item);
      } else if (item.dateTime.month == 6) {
        juneList.add(item);
      } else if (item.dateTime.month == 7) {
        julyList.add(item);
      } else if (item.dateTime.month == 8) {
        augustList.add(item);
      } else if (item.dateTime.month == 9) {
        septemberList.add(item);
      } else if (item.dateTime.month == 10) {
        octoberList.add(item);
      } else if (item.dateTime.month == 11) {
        novemberList.add(item);
      } else if (item.dateTime.month == 12) {
        decemberList.add(item);
      }
    }
  }

  late Box box;
  Future<List<TransactionModel>> fetchFromDatabase() async {
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
        arrayOfData.add(TransactionModel(
            element['amount'] as int,
            element['dateTime'] as DateTime,
            element['type'],
            element['note'],
            element['date']));
      });
      return items;
    }
  }

  List<TransactionModel> arrayOfData = [];

  @override
  void initState() {
    super.initState();
    box = Hive.box('transactions');
    fetchFromDatabase();
    getMonthsList(arrayOfData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0.0,
        backgroundColor: appThemeColor,
      ),
      body: ListView(
        children: [
          statisticsText(context),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                dropDownContainer(
                  context,
                  child: Center(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                          iconEnabledColor: Colors.white,
                          dropdownColor: appThemeColor,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                          borderRadius: BorderRadius.circular(10),
                          items: graphFilter
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          value: graphFilterValue,
                          onChanged: (String? newValue) {
                            setState(() {
                              graphFilterValue = newValue!;
                              _isvisible = newValue == 'Monthly';
                            });
                          }),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Visibility(
                  visible: _isvisible,
                  child: dropDownContainer(
                    context,
                    child: Center(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                            iconEnabledColor: Colors.white,
                            menuMaxHeight: 130.0,
                            dropdownColor: appThemeColor,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12),
                            borderRadius: BorderRadius.circular(10),
                            items: monthsFilter
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            value: monthsFilterValue,
                            onChanged: (String? newValue) {
                              setState(() {
                                monthsFilterValue = newValue!;
                              });
                            }),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          FutureBuilder<List<TransactionModel>>(
              future: fetchFromDatabase(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: SizedBox());
                }
                if (snapshot.hasData) {
                  getTotalBalance(snapshot.data!);
                  if (snapshot.data!.isEmpty) {
                    return Center(child: noGraph(context));
                  }
                  if (graphFilterValue == 'All') {
                    return graphWidget(
                        dataList: snapshot.data!, context: context);
                  } else if (graphFilterValue == 'Monthly' &&
                      monthsFilterValue == 'January') {
                    return graphWidget(dataList: januaryList, context: context);
                  } else if (graphFilterValue == 'Monthly' &&
                      monthsFilterValue == 'February') {
                    return graphWidget(
                        dataList: februaryList, context: context);
                  } else if (graphFilterValue == 'Monthly' &&
                      monthsFilterValue == 'March') {
                    return graphWidget(dataList: marchList, context: context);
                  } else if (graphFilterValue == 'Monthly' &&
                      monthsFilterValue == 'April') {
                    return graphWidget(dataList: aprilList, context: context);
                  } else if (graphFilterValue == 'Monthly' &&
                      monthsFilterValue == 'May') {
                    return graphWidget(dataList: mayList, context: context);
                  } else if (graphFilterValue == 'Monthly' &&
                      monthsFilterValue == 'June') {
                    return graphWidget(dataList: juneList, context: context);
                  } else if (graphFilterValue == 'Monthly' &&
                      monthsFilterValue == 'July') {
                    return graphWidget(dataList: julyList, context: context);
                  } else if (graphFilterValue == 'Monthly' &&
                      monthsFilterValue == 'August') {
                    return graphWidget(dataList: augustList, context: context);
                  } else if (graphFilterValue == 'Monthly' &&
                      monthsFilterValue == 'September') {
                    return graphWidget(
                        dataList: septemberList, context: context);
                  } else if (graphFilterValue == 'Monthly' &&
                      monthsFilterValue == 'October') {
                    return graphWidget(dataList: octoberList, context: context);
                  } else if (graphFilterValue == 'Monthly' &&
                      monthsFilterValue == 'November') {
                    return graphWidget(
                        dataList: novemberList, context: context);
                  } else if (graphFilterValue == 'Monthly' &&
                      monthsFilterValue == 'December') {
                    return graphWidget(
                        dataList: decemberList, context: context);
                  }
                  return const SizedBox();
                } else {
                  return const Center(
                    child: SizedBox(),
                  );
                }
              }),
        ],
      ),
    );
  }
}
