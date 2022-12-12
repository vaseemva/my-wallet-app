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
String yearFilterValue = 'JAN';

String dropDownValue = 'All';

class _AllTransactionScreenState extends State<AllTransactionScreen> {
  DateTimeRange dateRange =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());
  Future pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
        context: context,
        initialDateRange: dateRange,
        firstDate: DateTime(2000),
        lastDate: DateTime(2040));
    if (newDateRange == null) return;
    setState(() {
      dateRange = newDateRange;
    });
  }

  DateTime defaultDate = DateTime.now();
  final types = <String>[
    'All',
    'Income',
    'Expense',
  ];
  final itemDataFilter = <String>[
    'All',
    'Today',
    'Monthly',
    'Custom',
  ];

  final itemsYearFilter = <String>[
    'JAN',
    'FEB',
    'MAR',
    'APR',
    'MAY',
    'JUN',
    'JUL',
    'AUG',
    'SEP',
    'OCT',
    'NOV',
    'DEC'
  ];
  Dbhelper dbhelper = Dbhelper();
  @override
  Widget build(BuildContext context) {
    final startDate = dateRange.start;
    final endDate = dateRange.end;
    return Scaffold(
      backgroundColor: Colors.white,
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
                    width: dataFilterValue == 'Monthly' ||
                            dataFilterValue == 'Custom'
                        ? MediaQuery.of(context).size.width * 0.26
                        : MediaQuery.of(context).size.width * 0.30,
                    height: MediaQuery.of(context).size.height * 0.06,
                    decoration: BoxDecoration(
                        color: appThemeColor,
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Center(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                            alignment: AlignmentDirectional.center,
                            iconEnabledColor: Colors.white,
                            dropdownColor: appThemeColor,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14),
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
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: dataFilterValue == 'Monthly' ||
                            dataFilterValue == 'Custom'
                        ? MediaQuery.of(context).size.width * 0.26
                        : MediaQuery.of(context).size.width * 0.30,
                    height: MediaQuery.of(context).size.height * 0.06,
                    decoration: BoxDecoration(
                      color: appThemeColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                            alignment: AlignmentDirectional.center,
                            iconEnabledColor: Colors.white,
                            dropdownColor: appThemeColor,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14),
                            borderRadius: BorderRadius.circular(20),
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
                  ),
                  dataFilterValue == 'Monthly'
                      ? Row(
                        children: [
                        const  SizedBox(width: 8,),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.22,
                              height: MediaQuery.of(context).size.height * 0.06,
                              decoration: BoxDecoration(
                                  color: dataFilterValue == 'Monthly'
                                      ? appThemeColor
                                      : const Color.fromARGB(255, 201, 245, 235),
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: Center(
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                      alignment: AlignmentDirectional.center,
                                      disabledHint: const Text('Month'),
                                      menuMaxHeight: 200,
                                      iconEnabledColor: Colors.white,
                                      dropdownColor: appThemeColor,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 14),
                                      borderRadius: BorderRadius.circular(10),
                                      items: dataFilterValue == 'Monthly'
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
                              ),
                            ),
                        ],
                      )
                      : const SizedBox(),
                  dataFilterValue == 'Custom'
                      ? IconButton(
                          onPressed: () {
                            pickDateRange();
                          },
                          color: appThemeColor,
                          icon: Icon(
                            Icons.date_range,
                            size: MediaQuery.of(context).size.width * 0.11,
                          ))
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
                              //Custom
                            } else if (dataFilterValue == 'Custom') {
                              if (dataAtIndex.dateTime.isAfter(startDate) &&
                                  dataAtIndex.dateTime.isBefore(endDate)) {
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
                            } else if (dataFilterValue == 'Monthly') {
                              //Monthly
                              if (yearFilterValue == 'JAN' &&
                                  dataAtIndex.dateTime.month == 1) {
                                return allTransactionIncomeTile(
                                    dataAtIndex.amount,
                                    dataAtIndex.note,
                                    dataAtIndex.date,
                                    index,
                                    dataAtIndex.type,
                                    dataAtIndex.dateTime);
                              } else if (yearFilterValue == 'FEB' &&
                                  dataAtIndex.dateTime.month == 2) {
                                return allTransactionIncomeTile(
                                    dataAtIndex.amount,
                                    dataAtIndex.note,
                                    dataAtIndex.date,
                                    index,
                                    dataAtIndex.type,
                                    dataAtIndex.dateTime);
                              } else if (yearFilterValue == 'MAR' &&
                                  dataAtIndex.dateTime.month == 3) {
                                return allTransactionIncomeTile(
                                    dataAtIndex.amount,
                                    dataAtIndex.note,
                                    dataAtIndex.date,
                                    index,
                                    dataAtIndex.type,
                                    dataAtIndex.dateTime);
                              } else if (yearFilterValue == 'APR' &&
                                  dataAtIndex.dateTime.month == 4) {
                                return allTransactionIncomeTile(
                                    dataAtIndex.amount,
                                    dataAtIndex.note,
                                    dataAtIndex.date,
                                    index,
                                    dataAtIndex.type,
                                    dataAtIndex.dateTime);
                              } else if (yearFilterValue == 'MAY' &&
                                  dataAtIndex.dateTime.month == 5) {
                                return allTransactionIncomeTile(
                                    dataAtIndex.amount,
                                    dataAtIndex.note,
                                    dataAtIndex.date,
                                    index,
                                    dataAtIndex.type,
                                    dataAtIndex.dateTime);
                              } else if (yearFilterValue == 'JUN' &&
                                  dataAtIndex.dateTime.month == 6) {
                                return allTransactionIncomeTile(
                                    dataAtIndex.amount,
                                    dataAtIndex.note,
                                    dataAtIndex.date,
                                    index,
                                    dataAtIndex.type,
                                    dataAtIndex.dateTime);
                              } else if (yearFilterValue == 'JUL' &&
                                  dataAtIndex.dateTime.month == 7) {
                                return allTransactionIncomeTile(
                                    dataAtIndex.amount,
                                    dataAtIndex.note,
                                    dataAtIndex.date,
                                    index,
                                    dataAtIndex.type,
                                    dataAtIndex.dateTime);
                              } else if (yearFilterValue == 'AUG' &&
                                  dataAtIndex.dateTime.month == 8) {
                                return allTransactionIncomeTile(
                                    dataAtIndex.amount,
                                    dataAtIndex.note,
                                    dataAtIndex.date,
                                    index,
                                    dataAtIndex.type,
                                    dataAtIndex.dateTime);
                              } else if (yearFilterValue == 'SEP' &&
                                  dataAtIndex.dateTime.month == 9) {
                                return allTransactionIncomeTile(
                                    dataAtIndex.amount,
                                    dataAtIndex.note,
                                    dataAtIndex.date,
                                    index,
                                    dataAtIndex.type,
                                    dataAtIndex.dateTime);
                              } else if (yearFilterValue == 'OCT' &&
                                  dataAtIndex.dateTime.month == 10) {
                                return allTransactionIncomeTile(
                                    dataAtIndex.amount,
                                    dataAtIndex.note,
                                    dataAtIndex.date,
                                    index,
                                    dataAtIndex.type,
                                    dataAtIndex.dateTime);
                              } else if (yearFilterValue == 'NOV' &&
                                  dataAtIndex.dateTime.month == 11) {
                                return allTransactionIncomeTile(
                                    dataAtIndex.amount,
                                    dataAtIndex.note,
                                    dataAtIndex.date,
                                    index,
                                    dataAtIndex.type,
                                    dataAtIndex.dateTime);
                              } else if (yearFilterValue == 'DEC' &&
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
                            } else if (dataFilterValue == 'Custom') {
                              if (dataAtIndex.dateTime.isAfter(startDate) &&
                                  dataAtIndex.dateTime.isBefore(endDate)) {
                                return allTransactionExpenseTile(
                                    dataAtIndex.amount,
                                    dataAtIndex.note,
                                    dataAtIndex.date,
                                    index,
                                    dataAtIndex.type,
                                    dataAtIndex.dateTime);
                              }
                            } else if (dataFilterValue == 'Monthly') {
                              //Monthly
                              if (yearFilterValue == 'JAN' &&
                                  dataAtIndex.dateTime.month == 1) {
                                return allTransactionExpenseTile(
                                    dataAtIndex.amount,
                                    dataAtIndex.note,
                                    dataAtIndex.date,
                                    index,
                                    dataAtIndex.type,
                                    dataAtIndex.dateTime);
                              } else if (yearFilterValue == 'FEB' &&
                                  dataAtIndex.dateTime.month == 2) {
                                return allTransactionExpenseTile(
                                    dataAtIndex.amount,
                                    dataAtIndex.note,
                                    dataAtIndex.date,
                                    index,
                                    dataAtIndex.type,
                                    dataAtIndex.dateTime);
                              } else if (yearFilterValue == 'MAR' &&
                                  dataAtIndex.dateTime.month == 3) {
                                return allTransactionExpenseTile(
                                    dataAtIndex.amount,
                                    dataAtIndex.note,
                                    dataAtIndex.date,
                                    index,
                                    dataAtIndex.type,
                                    dataAtIndex.dateTime);
                              } else if (yearFilterValue == 'APR' &&
                                  dataAtIndex.dateTime.month == 4) {
                                return allTransactionExpenseTile(
                                    dataAtIndex.amount,
                                    dataAtIndex.note,
                                    dataAtIndex.date,
                                    index,
                                    dataAtIndex.type,
                                    dataAtIndex.dateTime);
                              } else if (yearFilterValue == 'MAY' &&
                                  dataAtIndex.dateTime.month == 5) {
                                return allTransactionExpenseTile(
                                    dataAtIndex.amount,
                                    dataAtIndex.note,
                                    dataAtIndex.date,
                                    index,
                                    dataAtIndex.type,
                                    dataAtIndex.dateTime);
                              } else if (yearFilterValue == 'JUN' &&
                                  dataAtIndex.dateTime.month == 6) {
                                return allTransactionExpenseTile(
                                    dataAtIndex.amount,
                                    dataAtIndex.note,
                                    dataAtIndex.date,
                                    index,
                                    dataAtIndex.type,
                                    dataAtIndex.dateTime);
                              } else if (yearFilterValue == 'JUL' &&
                                  dataAtIndex.dateTime.month == 7) {
                                return allTransactionExpenseTile(
                                    dataAtIndex.amount,
                                    dataAtIndex.note,
                                    dataAtIndex.date,
                                    index,
                                    dataAtIndex.type,
                                    dataAtIndex.dateTime);
                              } else if (yearFilterValue == 'AUG' &&
                                  dataAtIndex.dateTime.month == 8) {
                                return allTransactionExpenseTile(
                                    dataAtIndex.amount,
                                    dataAtIndex.note,
                                    dataAtIndex.date,
                                    index,
                                    dataAtIndex.type,
                                    dataAtIndex.dateTime);
                              } else if (yearFilterValue == 'SEP' &&
                                  dataAtIndex.dateTime.month == 9) {
                                return allTransactionExpenseTile(
                                    dataAtIndex.amount,
                                    dataAtIndex.note,
                                    dataAtIndex.date,
                                    index,
                                    dataAtIndex.type,
                                    dataAtIndex.dateTime);
                              } else if (yearFilterValue == 'OCT' &&
                                  dataAtIndex.dateTime.month == 10) {
                                return allTransactionExpenseTile(
                                    dataAtIndex.amount,
                                    dataAtIndex.note,
                                    dataAtIndex.date,
                                    index,
                                    dataAtIndex.type,
                                    dataAtIndex.dateTime);
                              } else if (yearFilterValue == 'NOV' &&
                                  dataAtIndex.dateTime.month == 11) {
                                return allTransactionExpenseTile(
                                    dataAtIndex.amount,
                                    dataAtIndex.note,
                                    dataAtIndex.date,
                                    index,
                                    dataAtIndex.type,
                                    dataAtIndex.dateTime);
                              } else if (yearFilterValue == 'DEC' &&
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
                                } else if (dataFilterValue == 'Custom') {
                                  if (dataAtIndex.dateTime.isAfter(startDate) &&
                                      dataAtIndex.dateTime.isBefore(endDate)) {
                                    return allTransactionIncomeTile(
                                        dataAtIndex.amount,
                                        dataAtIndex.note,
                                        dataAtIndex.date,
                                        index,
                                        dataAtIndex.type,
                                        dataAtIndex.dateTime);
                                  }
                                } else if (dataFilterValue == 'Monthly') {
                                  if (yearFilterValue == 'JAN' &&
                                      dataAtIndex.dateTime.month == 1) {
                                    return allTransactionIncomeTile(
                                        dataAtIndex.amount,
                                        dataAtIndex.note,
                                        dataAtIndex.date,
                                        index,
                                        dataAtIndex.type,
                                        dataAtIndex.dateTime);
                                  } else if (yearFilterValue == 'FEB' &&
                                      dataAtIndex.dateTime.month == 2) {
                                    return allTransactionIncomeTile(
                                        dataAtIndex.amount,
                                        dataAtIndex.note,
                                        dataAtIndex.date,
                                        index,
                                        dataAtIndex.type,
                                        dataAtIndex.dateTime);
                                  } else if (yearFilterValue == 'MAR' &&
                                      dataAtIndex.dateTime.month == 3) {
                                    return allTransactionIncomeTile(
                                        dataAtIndex.amount,
                                        dataAtIndex.note,
                                        dataAtIndex.date,
                                        index,
                                        dataAtIndex.type,
                                        dataAtIndex.dateTime);
                                  } else if (yearFilterValue == 'APR' &&
                                      dataAtIndex.dateTime.month == 4) {
                                    return allTransactionIncomeTile(
                                        dataAtIndex.amount,
                                        dataAtIndex.note,
                                        dataAtIndex.date,
                                        index,
                                        dataAtIndex.type,
                                        dataAtIndex.dateTime);
                                  } else if (yearFilterValue == 'MAY' &&
                                      dataAtIndex.dateTime.month == 5) {
                                    return allTransactionIncomeTile(
                                        dataAtIndex.amount,
                                        dataAtIndex.note,
                                        dataAtIndex.date,
                                        index,
                                        dataAtIndex.type,
                                        dataAtIndex.dateTime);
                                  } else if (yearFilterValue == 'JUN' &&
                                      dataAtIndex.dateTime.month == 6) {
                                    return allTransactionIncomeTile(
                                        dataAtIndex.amount,
                                        dataAtIndex.note,
                                        dataAtIndex.date,
                                        index,
                                        dataAtIndex.type,
                                        dataAtIndex.dateTime);
                                  } else if (yearFilterValue == 'JUL' &&
                                      dataAtIndex.dateTime.month == 7) {
                                    return allTransactionIncomeTile(
                                        dataAtIndex.amount,
                                        dataAtIndex.note,
                                        dataAtIndex.date,
                                        index,
                                        dataAtIndex.type,
                                        dataAtIndex.dateTime);
                                  } else if (yearFilterValue == 'AUG' &&
                                      dataAtIndex.dateTime.month == 8) {
                                    return allTransactionIncomeTile(
                                        dataAtIndex.amount,
                                        dataAtIndex.note,
                                        dataAtIndex.date,
                                        index,
                                        dataAtIndex.type,
                                        dataAtIndex.dateTime);
                                  } else if (yearFilterValue == 'SEP' &&
                                      dataAtIndex.dateTime.month == 9) {
                                    return allTransactionIncomeTile(
                                        dataAtIndex.amount,
                                        dataAtIndex.note,
                                        dataAtIndex.date,
                                        index,
                                        dataAtIndex.type,
                                        dataAtIndex.dateTime);
                                  } else if (yearFilterValue == 'OCT' &&
                                      dataAtIndex.dateTime.month == 10) {
                                    return allTransactionIncomeTile(
                                        dataAtIndex.amount,
                                        dataAtIndex.note,
                                        dataAtIndex.date,
                                        index,
                                        dataAtIndex.type,
                                        dataAtIndex.dateTime);
                                  } else if (yearFilterValue == 'NOV' &&
                                      dataAtIndex.dateTime.month == 11) {
                                    return allTransactionIncomeTile(
                                        dataAtIndex.amount,
                                        dataAtIndex.note,
                                        dataAtIndex.date,
                                        index,
                                        dataAtIndex.type,
                                        dataAtIndex.dateTime);
                                  } else if (yearFilterValue == 'DEC' &&
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
                                } else if (dataFilterValue == 'Custom') {
                                  if (dataAtIndex.dateTime.isAfter(startDate) &&
                                      dataAtIndex.dateTime.isBefore(endDate)) {
                                    return allTransactionExpenseTile(
                                        dataAtIndex.amount,
                                        dataAtIndex.note,
                                        dataAtIndex.date,
                                        index,
                                        dataAtIndex.type,
                                        dataAtIndex.dateTime);
                                  }
                                } else if (dataFilterValue == 'Monthly') {
                                  if (yearFilterValue == 'JAN' &&
                                      dataAtIndex.dateTime.month == 1) {
                                    return allTransactionExpenseTile(
                                        dataAtIndex.amount,
                                        dataAtIndex.note,
                                        dataAtIndex.date,
                                        index,
                                        dataAtIndex.type,
                                        dataAtIndex.dateTime);
                                  } else if (yearFilterValue == 'FEB' &&
                                      dataAtIndex.dateTime.month == 2) {
                                    return allTransactionExpenseTile(
                                        dataAtIndex.amount,
                                        dataAtIndex.note,
                                        dataAtIndex.date,
                                        index,
                                        dataAtIndex.type,
                                        dataAtIndex.dateTime);
                                  } else if (yearFilterValue == 'MAR' &&
                                      dataAtIndex.dateTime.month == 3) {
                                    return allTransactionExpenseTile(
                                        dataAtIndex.amount,
                                        dataAtIndex.note,
                                        dataAtIndex.date,
                                        index,
                                        dataAtIndex.type,
                                        dataAtIndex.dateTime);
                                  } else if (yearFilterValue == 'APR' &&
                                      dataAtIndex.dateTime.month == 4) {
                                    return allTransactionExpenseTile(
                                        dataAtIndex.amount,
                                        dataAtIndex.note,
                                        dataAtIndex.date,
                                        index,
                                        dataAtIndex.type,
                                        dataAtIndex.dateTime);
                                  } else if (yearFilterValue == 'MAY' &&
                                      dataAtIndex.dateTime.month == 5) {
                                    return allTransactionExpenseTile(
                                        dataAtIndex.amount,
                                        dataAtIndex.note,
                                        dataAtIndex.date,
                                        index,
                                        dataAtIndex.type,
                                        dataAtIndex.dateTime);
                                  } else if (yearFilterValue == 'JUN' &&
                                      dataAtIndex.dateTime.month == 6) {
                                    return allTransactionExpenseTile(
                                        dataAtIndex.amount,
                                        dataAtIndex.note,
                                        dataAtIndex.date,
                                        index,
                                        dataAtIndex.type,
                                        dataAtIndex.dateTime);
                                  } else if (yearFilterValue == 'JUL' &&
                                      dataAtIndex.dateTime.month == 7) {
                                    return allTransactionExpenseTile(
                                        dataAtIndex.amount,
                                        dataAtIndex.note,
                                        dataAtIndex.date,
                                        index,
                                        dataAtIndex.type,
                                        dataAtIndex.dateTime);
                                  } else if (yearFilterValue == 'AUG' &&
                                      dataAtIndex.dateTime.month == 8) {
                                    return allTransactionExpenseTile(
                                        dataAtIndex.amount,
                                        dataAtIndex.note,
                                        dataAtIndex.date,
                                        index,
                                        dataAtIndex.type,
                                        dataAtIndex.dateTime);
                                  } else if (yearFilterValue == 'SEP' &&
                                      dataAtIndex.dateTime.month == 9) {
                                    return allTransactionExpenseTile(
                                        dataAtIndex.amount,
                                        dataAtIndex.note,
                                        dataAtIndex.date,
                                        index,
                                        dataAtIndex.type,
                                        dataAtIndex.dateTime);
                                  } else if (yearFilterValue == 'OCT' &&
                                      dataAtIndex.dateTime.month == 10) {
                                    return allTransactionExpenseTile(
                                        dataAtIndex.amount,
                                        dataAtIndex.note,
                                        dataAtIndex.date,
                                        index,
                                        dataAtIndex.type,
                                        dataAtIndex.dateTime);
                                  } else if (yearFilterValue == 'NOV' &&
                                      dataAtIndex.dateTime.month == 11) {
                                    return allTransactionExpenseTile(
                                        dataAtIndex.amount,
                                        dataAtIndex.note,
                                        dataAtIndex.date,
                                        index,
                                        dataAtIndex.type,
                                        dataAtIndex.dateTime);
                                  } else if (yearFilterValue == 'DEC' &&
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
