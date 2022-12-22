import 'package:flutter/material.dart';
import 'package:my_wallet_app/colors/colors.dart';
import 'package:my_wallet_app/controllers/db_helper.dart';
import 'package:my_wallet_app/models/transaction_model.dart';
import 'package:my_wallet_app/screens/all%20transaction%20screen/widgets/all_transaction_widget.dart';
import 'package:my_wallet_app/screens/all%20transaction%20screen/widgets/widgets.dart';

class AllTransactionScreen extends StatefulWidget {
  const AllTransactionScreen({super.key});

  @override
  State<AllTransactionScreen> createState() => _AllTransactionScreenState();
}

bool monthlydropdownvisiblity = false;
bool customdatevisiblity = false;
String dataFilterValue = 'All';
String yearFilterValue = 'JAN';
String dropDownValue = 'All';
DateTimeRange dateRange =
    DateTimeRange(start: DateTime.now(), end: DateTime.now());

class _AllTransactionScreenState extends State<AllTransactionScreen> {
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
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
                              items: types.map<DropdownMenuItem<String>>(
                                  (String value) {
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
                    dataFilterValue == 'Monthly' || dataFilterValue == 'Custom'
                        ? const SizedBox(width: 7)
                        : SizedBox(
                            width: MediaQuery.of(context).size.width * 0.15),
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
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              value: dataFilterValue,
                              onChanged: (String? newValue) {
                                setState(() {
                                  dataFilterValue = newValue!;
                                  monthlydropdownvisiblity =
                                      dataFilterValue == 'Monthly';
                                  customdatevisiblity =
                                      dataFilterValue == 'Custom';
                                });
                              }),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: monthlydropdownvisiblity,
                      child: Row(
                        children: [
                          const SizedBox(width: 8),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.20,
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
                      ),
                    ),
                    Visibility(
                      visible: customdatevisiblity,
                      child: IconButton(
                          padding: const EdgeInsets.only(bottom: 0),
                          onPressed: () {
                            pickDateRange();
                          },
                          color: appThemeColor,
                          icon: Icon(
                            Icons.date_range,
                            size: MediaQuery.of(context).size.height * 0.06,
                          )),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            FutureBuilder<List<TransactionModel>>(
                future: dbhelper.fetchSavedData(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                        child: Text("Unexpected Error Occured !!"));
                  }
                  if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return Center(child: noDataCard());
                    }
                    return AllTransactionWidget(data: snapshot.data!);
                  }
                  return const SizedBox();
                })
          ],
        ),
      ),
    );
  }
}
