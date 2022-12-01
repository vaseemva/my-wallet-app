import 'package:flutter/material.dart';

import 'package:my_wallet_app/colors/colors.dart';
import 'package:my_wallet_app/controllers/db_helper.dart';
import 'package:my_wallet_app/models/transaction_model.dart';
import 'package:my_wallet_app/screens/all%20transaction%20screen/widgets.dart';

class AllTransactionScreen extends StatefulWidget {
  const AllTransactionScreen({super.key});

  @override
  State<AllTransactionScreen> createState() => _AllTransactionScreenState();
}

String dataFilterValue = 'All';
String yearFilterValue = 'January';

String dropDownValue = 'All';

class _AllTransactionScreenState extends State<AllTransactionScreen> {
  DateTime defaultDate = DateTime.now();
  final types = <String>[
    'All',
    'Income',
    'Expense',
  ];
  final itemDataFilter = <String>[
    'All',
    'Today',
    'This Month',
    'This Year',
  ];

  final itemsYearFilter = <String>[
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
  Dbhelper dbhelper = Dbhelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('All Transactions',
            style: TextStyle(color: Colors.black, fontSize: 22)),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: ListView(
          children: [
            SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: dataFilterValue == 'This Year'
                        ? MediaQuery.of(context).size.width * 0.26
                        : MediaQuery.of(context).size.width * 0.40,
                    height: MediaQuery.of(context).size.height * 0.06,
                    decoration: BoxDecoration(
                        color: appThemeColor,
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Center(
                      child: DropdownButton(
                          iconEnabledColor: Colors.white,
                          dropdownColor: appThemeColor,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                          items: types
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          value: dropDownValue,
                          onChanged: (String? newvalue) {
                            setState(() {
                              dropDownValue = newvalue!;
                            });
                          }),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: dataFilterValue == 'This Year'
                        ? MediaQuery.of(context).size.width * 0.26
                        : MediaQuery.of(context).size.width * 0.40,
                    height: MediaQuery.of(context).size.height * 0.06,
                    decoration: BoxDecoration(
                      color: appThemeColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: DropdownButton<String>(
                          iconEnabledColor: Colors.white,
                          dropdownColor: appThemeColor,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                          borderRadius: BorderRadius.circular(10),
                          items: itemDataFilter
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          value: dataFilterValue,
                          onChanged: (String? newValue) {
                            setState(() {
                              dataFilterValue = newValue!;
                            });
                          }),
                    ),
                  ),
                  dataFilterValue == 'This Year'
                      ? Container(
                          width: MediaQuery.of(context).size.width * 0.26,
                          height: MediaQuery.of(context).size.height * 0.06,
                          decoration: BoxDecoration(
                              color: dataFilterValue == 'This Year'
                                  ? appThemeColor
                                  : const Color.fromARGB(255, 201, 245, 235),
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Center(
                            child: DropdownButton(
                                disabledHint: const Text('Month'),
                                menuMaxHeight: 200,
                                iconEnabledColor: Colors.white,
                                dropdownColor: appThemeColor,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12),
                                borderRadius: BorderRadius.circular(10),
                                items: dataFilterValue == 'This Year'
                                    ? itemsYearFilter
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList()
                                    : null,
                                value: yearFilterValue,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    yearFilterValue = newValue!;
                                  });
                                }),
                          ),
                        )
                      : const SizedBox()
                ],
              ),
            ),
            const SizedBox(height: 20),
            FutureBuilder<List<TransactionModel>>(
                future: dbhelper.fetch(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                        child: Text("Unexpected Error Occured !!"));
                  }
                  if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return Center(child: noDataCard());
                    }

                    return ListView.builder(
                        shrinkWrap: true,
                        reverse: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          TransactionModel dataAtIndex = snapshot.data![index];
                          //filters for income
                          if (dropDownValue == 'Income' &&
                              dataAtIndex.type == 'income') {
                            if (dataFilterValue == 'Today') {
                              if (dataAtIndex.dateTime.month ==
                                      defaultDate.month &&
                                  dataAtIndex.dateTime.day == defaultDate.day) {
                                return allTransactionIncomeTile(
                                    dataAtIndex.amount,
                                    dataAtIndex.note,
                                    dataAtIndex.date,
                                    index,
                                    dataAtIndex.type,
                                    dataAtIndex.dateTime);
                              }
                              //this month
                            } else if (dataFilterValue == 'This Month') {
                              if (dataAtIndex.dateTime.month ==
                                  defaultDate.month) {
                                return allTransactionIncomeTile(
                                    dataAtIndex.amount,
                                    dataAtIndex.note,
                                    dataAtIndex.date,
                                    index,
                                    dataAtIndex.type,
                                    dataAtIndex.dateTime);
                              }
                              //all
                            } else if (dataFilterValue == 'All') {
                              return allTransactionIncomeTile(
                                  dataAtIndex.amount,
                                  dataAtIndex.note,
                                  dataAtIndex.date,
                                  index,
                                  dataAtIndex.type,
                                  dataAtIndex.dateTime);
                            } else if (dataFilterValue == 'This Year') {
                              //This year
                              if (yearFilterValue == 'January' &&
                                  dataAtIndex.dateTime.month == 1) {
                                return allTransactionIncomeTile(
                                    dataAtIndex.amount,
                                    dataAtIndex.note,
                                    dataAtIndex.date,
                                    index,
                                    dataAtIndex.type,
                                    dataAtIndex.dateTime);
                              } else if (yearFilterValue == 'February' &&
                                  dataAtIndex.dateTime.month == 2) {
                                return allTransactionIncomeTile(
                                    dataAtIndex.amount,
                                    dataAtIndex.note,
                                    dataAtIndex.date,
                                    index,
                                    dataAtIndex.type,
                                    dataAtIndex.dateTime);
                              } else if (yearFilterValue == 'March' &&
                                  dataAtIndex.dateTime.month == 3) {
                                return allTransactionIncomeTile(
                                    dataAtIndex.amount,
                                    dataAtIndex.note,
                                    dataAtIndex.date,
                                    index,
                                    dataAtIndex.type,
                                    dataAtIndex.dateTime);
                              } else if (yearFilterValue == 'April' &&
                                  dataAtIndex.dateTime.month == 4) {
                                return allTransactionIncomeTile(
                                    dataAtIndex.amount,
                                    dataAtIndex.note,
                                    dataAtIndex.date,
                                    index,
                                    dataAtIndex.type,
                                    dataAtIndex.dateTime);
                              } else if (yearFilterValue == 'May' &&
                                  dataAtIndex.dateTime.month == 5) {
                                return allTransactionIncomeTile(
                                    dataAtIndex.amount,
                                    dataAtIndex.note,
                                    dataAtIndex.date,
                                    index,
                                    dataAtIndex.type,
                                    dataAtIndex.dateTime);
                              } else if (yearFilterValue == 'June' &&
                                  dataAtIndex.dateTime.month == 6) {
                                return allTransactionIncomeTile(
                                    dataAtIndex.amount,
                                    dataAtIndex.note,
                                    dataAtIndex.date,
                                    index,
                                    dataAtIndex.type,
                                    dataAtIndex.dateTime);
                              } else if (yearFilterValue == 'July' &&
                                  dataAtIndex.dateTime.month == 7) {
                                return allTransactionIncomeTile(
                                    dataAtIndex.amount,
                                    dataAtIndex.note,
                                    dataAtIndex.date,
                                    index,
                                    dataAtIndex.type,
                                    dataAtIndex.dateTime);
                              } else if (yearFilterValue == 'August' &&
                                  dataAtIndex.dateTime.month == 8) {
                                return allTransactionIncomeTile(
                                    dataAtIndex.amount,
                                    dataAtIndex.note,
                                    dataAtIndex.date,
                                    index,
                                    dataAtIndex.type,
                                    dataAtIndex.dateTime);
                              } else if (yearFilterValue == 'September' &&
                                  dataAtIndex.dateTime.month == 9) {
                                return allTransactionIncomeTile(
                                    dataAtIndex.amount,
                                    dataAtIndex.note,
                                    dataAtIndex.date,
                                    index,
                                    dataAtIndex.type,
                                    dataAtIndex.dateTime);
                              } else if (yearFilterValue == 'October' &&
                                  dataAtIndex.dateTime.month == 10) {
                                return allTransactionIncomeTile(
                                    dataAtIndex.amount,
                                    dataAtIndex.note,
                                    dataAtIndex.date,
                                    index,
                                    dataAtIndex.type,
                                    dataAtIndex.dateTime);
                              } else if (yearFilterValue == 'November' &&
                                  dataAtIndex.dateTime.month == 11) {
                                return allTransactionIncomeTile(
                                    dataAtIndex.amount,
                                    dataAtIndex.note,
                                    dataAtIndex.date,
                                    index,
                                    dataAtIndex.type,
                                    dataAtIndex.dateTime);
                              } else if (yearFilterValue == 'December' &&
                                  dataAtIndex.dateTime.month == 12) {
                                return allTransactionIncomeTile(
                                    dataAtIndex.amount,
                                    dataAtIndex.note,
                                    dataAtIndex.date,
                                    index,
                                    dataAtIndex.type,
                                    dataAtIndex.dateTime);
                              }
                            }
                          } else if (dropDownValue == 'Expense' &&
                              dataAtIndex.type == 'expense') {
                            /////Expense Filtration

                            if (dataFilterValue == 'All') {
                              return allTransactionExpenseTile(
                                  dataAtIndex.amount,
                                  dataAtIndex.note,
                                  dataAtIndex.date,
                                  index,
                                  dataAtIndex.type,
                                  dataAtIndex.dateTime);
                            } else if (dataFilterValue == 'Today') {
                              if (dataAtIndex.dateTime.month ==
                                      defaultDate.month &&
                                  dataAtIndex.dateTime.day == defaultDate.day) {
                                return allTransactionExpenseTile(
                                    dataAtIndex.amount,
                                    dataAtIndex.note,
                                    dataAtIndex.date,
                                    index,
                                    dataAtIndex.type,
                                    dataAtIndex.dateTime);
                              }
                            } else if (dataFilterValue == 'This Month') {
                              if (dataAtIndex.dateTime.month ==
                                  defaultDate.month) {
                                return allTransactionExpenseTile(
                                    dataAtIndex.amount,
                                    dataAtIndex.note,
                                    dataAtIndex.date,
                                    index,
                                    dataAtIndex.type,
                                    dataAtIndex.dateTime);
                              }
                            } else if (dataFilterValue == 'This Year') {
                              //This year
                              if (yearFilterValue == 'January' &&
                                  dataAtIndex.dateTime.month == 1) {
                                return allTransactionExpenseTile(
                                    dataAtIndex.amount,
                                    dataAtIndex.note,
                                    dataAtIndex.date,
                                    index,
                                    dataAtIndex.type,
                                    dataAtIndex.dateTime);
                              } else if (yearFilterValue == 'February' &&
                                  dataAtIndex.dateTime.month == 2) {
                                return allTransactionExpenseTile(
                                    dataAtIndex.amount,
                                    dataAtIndex.note,
                                    dataAtIndex.date,
                                    index,
                                    dataAtIndex.type,
                                    dataAtIndex.dateTime);
                              } else if (yearFilterValue == 'March' &&
                                  dataAtIndex.dateTime.month == 3) {
                                return allTransactionExpenseTile(
                                    dataAtIndex.amount,
                                    dataAtIndex.note,
                                    dataAtIndex.date,
                                    index,
                                    dataAtIndex.type,
                                    dataAtIndex.dateTime);
                              } else if (yearFilterValue == 'April' &&
                                  dataAtIndex.dateTime.month == 4) {
                                return allTransactionExpenseTile(
                                    dataAtIndex.amount,
                                    dataAtIndex.note,
                                    dataAtIndex.date,
                                    index,
                                    dataAtIndex.type,
                                    dataAtIndex.dateTime);
                              } else if (yearFilterValue == 'May' &&
                                  dataAtIndex.dateTime.month == 5) {
                                return allTransactionExpenseTile(
                                    dataAtIndex.amount,
                                    dataAtIndex.note,
                                    dataAtIndex.date,
                                    index,
                                    dataAtIndex.type,
                                    dataAtIndex.dateTime);
                              } else if (yearFilterValue == 'June' &&
                                  dataAtIndex.dateTime.month == 6) {
                                return allTransactionExpenseTile(
                                    dataAtIndex.amount,
                                    dataAtIndex.note,
                                    dataAtIndex.date,
                                    index,
                                    dataAtIndex.type,
                                    dataAtIndex.dateTime);
                              } else if (yearFilterValue == 'July' &&
                                  dataAtIndex.dateTime.month == 7) {
                                return allTransactionExpenseTile(
                                    dataAtIndex.amount,
                                    dataAtIndex.note,
                                    dataAtIndex.date,
                                    index,
                                    dataAtIndex.type,
                                    dataAtIndex.dateTime);
                              } else if (yearFilterValue == 'August' &&
                                  dataAtIndex.dateTime.month == 8) {
                                return allTransactionExpenseTile(
                                    dataAtIndex.amount,
                                    dataAtIndex.note,
                                    dataAtIndex.date,
                                    index,
                                    dataAtIndex.type,
                                    dataAtIndex.dateTime);
                              } else if (yearFilterValue == 'September' &&
                                  dataAtIndex.dateTime.month == 9) {
                                return allTransactionExpenseTile(
                                    dataAtIndex.amount,
                                    dataAtIndex.note,
                                    dataAtIndex.date,
                                    index,
                                    dataAtIndex.type,
                                    dataAtIndex.dateTime);
                              } else if (yearFilterValue == 'October' &&
                                  dataAtIndex.dateTime.month == 10) {
                                return allTransactionExpenseTile(
                                    dataAtIndex.amount,
                                    dataAtIndex.note,
                                    dataAtIndex.date,
                                    index,
                                    dataAtIndex.type,
                                    dataAtIndex.dateTime);
                              } else if (yearFilterValue == 'November' &&
                                  dataAtIndex.dateTime.month == 11) {
                                return allTransactionExpenseTile(
                                    dataAtIndex.amount,
                                    dataAtIndex.note,
                                    dataAtIndex.date,
                                    index,
                                    dataAtIndex.type,
                                    dataAtIndex.dateTime);
                              } else if (yearFilterValue == 'December' &&
                                  dataAtIndex.dateTime.month == 12) {
                                return allTransactionExpenseTile(
                                    dataAtIndex.amount,
                                    dataAtIndex.note,
                                    dataAtIndex.date,
                                    index,
                                    dataAtIndex.type,
                                    dataAtIndex.dateTime);
                              }
                            }
                          } else {
                            if (dropDownValue == 'All') {
                              if (dataAtIndex.type == 'income') {
                                if (dataFilterValue == 'All') {
                                  return allTransactionIncomeTile(
                                      dataAtIndex.amount,
                                      dataAtIndex.note,
                                      dataAtIndex.date,
                                      index,
                                      dataAtIndex.type,
                                      dataAtIndex.dateTime);
                                } else if (dataFilterValue == 'Today') {
                                  if (dataAtIndex.dateTime.month ==
                                          defaultDate.month &&
                                      dataAtIndex.dateTime.day ==
                                          defaultDate.day) {
                                    return allTransactionIncomeTile(
                                        dataAtIndex.amount,
                                        dataAtIndex.note,
                                        dataAtIndex.date,
                                        index,
                                        dataAtIndex.type,
                                        dataAtIndex.dateTime);
                                  }
                                } else if (dataFilterValue == 'This Month') {
                                  if (dataAtIndex.dateTime.month ==
                                      defaultDate.month) {
                                    return allTransactionIncomeTile(
                                        dataAtIndex.amount,
                                        dataAtIndex.note,
                                        dataAtIndex.date,
                                        index,
                                        dataAtIndex.type,
                                        dataAtIndex.dateTime);
                                  }
                                } else if (dataFilterValue == 'This Year') {
                                  if (yearFilterValue == 'January' &&
                                      dataAtIndex.dateTime.month == 1) {
                                    return allTransactionIncomeTile(
                                        dataAtIndex.amount,
                                        dataAtIndex.note,
                                        dataAtIndex.date,
                                        index,
                                        dataAtIndex.type,
                                        dataAtIndex.dateTime);
                                  } else if (yearFilterValue == 'February' &&
                                      dataAtIndex.dateTime.month == 2) {
                                    return allTransactionIncomeTile(
                                        dataAtIndex.amount,
                                        dataAtIndex.note,
                                        dataAtIndex.date,
                                        index,
                                        dataAtIndex.type,
                                        dataAtIndex.dateTime);
                                  } else if (yearFilterValue == 'March' &&
                                      dataAtIndex.dateTime.month == 3) {
                                    return allTransactionIncomeTile(
                                        dataAtIndex.amount,
                                        dataAtIndex.note,
                                        dataAtIndex.date,
                                        index,
                                        dataAtIndex.type,
                                        dataAtIndex.dateTime);
                                  } else if (yearFilterValue == 'April' &&
                                      dataAtIndex.dateTime.month == 4) {
                                    return allTransactionIncomeTile(
                                        dataAtIndex.amount,
                                        dataAtIndex.note,
                                        dataAtIndex.date,
                                        index,
                                        dataAtIndex.type,
                                        dataAtIndex.dateTime);
                                  } else if (yearFilterValue == 'May' &&
                                      dataAtIndex.dateTime.month == 5) {
                                    return allTransactionIncomeTile(
                                        dataAtIndex.amount,
                                        dataAtIndex.note,
                                        dataAtIndex.date,
                                        index,
                                        dataAtIndex.type,
                                        dataAtIndex.dateTime);
                                  } else if (yearFilterValue == 'June' &&
                                      dataAtIndex.dateTime.month == 6) {
                                    return allTransactionIncomeTile(
                                        dataAtIndex.amount,
                                        dataAtIndex.note,
                                        dataAtIndex.date,
                                        index,
                                        dataAtIndex.type,
                                        dataAtIndex.dateTime);
                                  } else if (yearFilterValue == 'July' &&
                                      dataAtIndex.dateTime.month == 7) {
                                    return allTransactionIncomeTile(
                                        dataAtIndex.amount,
                                        dataAtIndex.note,
                                        dataAtIndex.date,
                                        index,
                                        dataAtIndex.type,
                                        dataAtIndex.dateTime);
                                  } else if (yearFilterValue == 'August' &&
                                      dataAtIndex.dateTime.month == 8) {
                                    return allTransactionIncomeTile(
                                        dataAtIndex.amount,
                                        dataAtIndex.note,
                                        dataAtIndex.date,
                                        index,
                                        dataAtIndex.type,
                                        dataAtIndex.dateTime);
                                  } else if (yearFilterValue == 'September' &&
                                      dataAtIndex.dateTime.month == 9) {
                                    return allTransactionIncomeTile(
                                        dataAtIndex.amount,
                                        dataAtIndex.note,
                                        dataAtIndex.date,
                                        index,
                                        dataAtIndex.type,
                                        dataAtIndex.dateTime);
                                  } else if (yearFilterValue == 'October' &&
                                      dataAtIndex.dateTime.month == 10) {
                                    return allTransactionIncomeTile(
                                        dataAtIndex.amount,
                                        dataAtIndex.note,
                                        dataAtIndex.date,
                                        index,
                                        dataAtIndex.type,
                                        dataAtIndex.dateTime);
                                  } else if (yearFilterValue == 'November' &&
                                      dataAtIndex.dateTime.month == 11) {
                                    return allTransactionIncomeTile(
                                        dataAtIndex.amount,
                                        dataAtIndex.note,
                                        dataAtIndex.date,
                                        index,
                                        dataAtIndex.type,
                                        dataAtIndex.dateTime);
                                  } else if (yearFilterValue == 'December' &&
                                      dataAtIndex.dateTime.month == 12) {
                                    return allTransactionIncomeTile(
                                        dataAtIndex.amount,
                                        dataAtIndex.note,
                                        dataAtIndex.date,
                                        index,
                                        dataAtIndex.type,
                                        dataAtIndex.dateTime);
                                  }
                                }
                              } else {
                                if (dataFilterValue == 'All') {
                                  return allTransactionExpenseTile(
                                      dataAtIndex.amount,
                                      dataAtIndex.note,
                                      dataAtIndex.date,
                                      index,
                                      dataAtIndex.type,
                                      dataAtIndex.dateTime);
                                } else if (dataFilterValue == 'Today') {
                                  if (dataAtIndex.dateTime.month ==
                                          defaultDate.month &&
                                      dataAtIndex.dateTime.day ==
                                          defaultDate.day) {
                                    return allTransactionExpenseTile(
                                        dataAtIndex.amount,
                                        dataAtIndex.note,
                                        dataAtIndex.date,
                                        index,
                                        dataAtIndex.type,
                                        dataAtIndex.dateTime);
                                  }
                                } else if (dataFilterValue == 'This Month') {
                                  if (dataAtIndex.dateTime.month ==
                                      defaultDate.month) {
                                    return allTransactionExpenseTile(
                                        dataAtIndex.amount,
                                        dataAtIndex.note,
                                        dataAtIndex.date,
                                        index,
                                        dataAtIndex.type,
                                        dataAtIndex.dateTime);
                                  }
                                } else if (dataFilterValue == 'This Year') {
                                  if (yearFilterValue == 'January' &&
                                      dataAtIndex.dateTime.month == 1) {
                                    return allTransactionExpenseTile(
                                        dataAtIndex.amount,
                                        dataAtIndex.note,
                                        dataAtIndex.date,
                                        index,
                                        dataAtIndex.type,
                                        dataAtIndex.dateTime);
                                  } else if (yearFilterValue == 'February' &&
                                      dataAtIndex.dateTime.month == 2) {
                                    return allTransactionExpenseTile(
                                        dataAtIndex.amount,
                                        dataAtIndex.note,
                                        dataAtIndex.date,
                                        index,
                                        dataAtIndex.type,
                                        dataAtIndex.dateTime);
                                  } else if (yearFilterValue == 'March' &&
                                      dataAtIndex.dateTime.month == 3) {
                                    return allTransactionExpenseTile(
                                        dataAtIndex.amount,
                                        dataAtIndex.note,
                                        dataAtIndex.date,
                                        index,
                                        dataAtIndex.type,
                                        dataAtIndex.dateTime);
                                  } else if (yearFilterValue == 'April' &&
                                      dataAtIndex.dateTime.month == 4) {
                                    return allTransactionExpenseTile(
                                        dataAtIndex.amount,
                                        dataAtIndex.note,
                                        dataAtIndex.date,
                                        index,
                                        dataAtIndex.type,
                                        dataAtIndex.dateTime);
                                  } else if (yearFilterValue == 'May' &&
                                      dataAtIndex.dateTime.month == 5) {
                                    return allTransactionExpenseTile(
                                        dataAtIndex.amount,
                                        dataAtIndex.note,
                                        dataAtIndex.date,
                                        index,
                                        dataAtIndex.type,
                                        dataAtIndex.dateTime);
                                  } else if (yearFilterValue == 'June' &&
                                      dataAtIndex.dateTime.month == 6) {
                                    return allTransactionExpenseTile(
                                        dataAtIndex.amount,
                                        dataAtIndex.note,
                                        dataAtIndex.date,
                                        index,
                                        dataAtIndex.type,
                                        dataAtIndex.dateTime);
                                  } else if (yearFilterValue == 'July' &&
                                      dataAtIndex.dateTime.month == 7) {
                                    return allTransactionExpenseTile(
                                        dataAtIndex.amount,
                                        dataAtIndex.note,
                                        dataAtIndex.date,
                                        index,
                                        dataAtIndex.type,
                                        dataAtIndex.dateTime);
                                  } else if (yearFilterValue == 'August' &&
                                      dataAtIndex.dateTime.month == 8) {
                                    return allTransactionExpenseTile(
                                        dataAtIndex.amount,
                                        dataAtIndex.note,
                                        dataAtIndex.date,
                                        index,
                                        dataAtIndex.type,
                                        dataAtIndex.dateTime);
                                  } else if (yearFilterValue == 'September' &&
                                      dataAtIndex.dateTime.month == 9) {
                                    return allTransactionExpenseTile(
                                        dataAtIndex.amount,
                                        dataAtIndex.note,
                                        dataAtIndex.date,
                                        index,
                                        dataAtIndex.type,
                                        dataAtIndex.dateTime);
                                  } else if (yearFilterValue == 'October' &&
                                      dataAtIndex.dateTime.month == 10) {
                                    return allTransactionExpenseTile(
                                        dataAtIndex.amount,
                                        dataAtIndex.note,
                                        dataAtIndex.date,
                                        index,
                                        dataAtIndex.type,
                                        dataAtIndex.dateTime);
                                  } else if (yearFilterValue == 'November' &&
                                      dataAtIndex.dateTime.month == 11) {
                                    return allTransactionExpenseTile(
                                        dataAtIndex.amount,
                                        dataAtIndex.note,
                                        dataAtIndex.date,
                                        index,
                                        dataAtIndex.type,
                                        dataAtIndex.dateTime);
                                  } else if (yearFilterValue == 'December' &&
                                      dataAtIndex.dateTime.month == 12) {
                                    return allTransactionExpenseTile(
                                        dataAtIndex.amount,
                                        dataAtIndex.note,
                                        dataAtIndex.date,
                                        index,
                                        dataAtIndex.type,
                                        dataAtIndex.dateTime);
                                  }
                                }
                              }
                            }
                          }
                          return const SizedBox();
                        });
                  }
                  return const SizedBox();
                })
          ],
        ),
      ),
    );
  }
}
