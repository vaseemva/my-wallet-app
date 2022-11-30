import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_wallet_app/colors/colors.dart';
import 'package:my_wallet_app/controllers/db_helper.dart';

import 'package:my_wallet_app/screens/home%20screens/home_screen.dart';


int expenses = 0;

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  int? amount;
  String  note = '';
  String type = 'income';
  DateTime selectedDate = DateTime.now();
  List<String> months = [
    "JAN",
    "FEB",
    "MAR",
    "APR",
    "MAY",
    "JUN",
    "JUL",
    "AUG",
    "SEP",
    "OCT",
    "NOV",
    "DEC"
  ];

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2020, 12),
        lastDate: DateTime(2200, 12));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Add Transaction',style: TextStyle(color: Colors.black),),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SizedBox(
            height: 50.0,
          ),
          Row(
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: appThemeColor,
                      borderRadius: BorderRadius.circular(16.0)),
                  padding: const EdgeInsets.all(12.0),
                  child: const Icon(
                    Icons.currency_rupee,
                    color: Colors.white,
                  )),
              const SizedBox(
                width: 15.0,
              ),
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                      hintText: '0', border: InputBorder.none),
                  style: const TextStyle(fontSize: 24.0),
                  onChanged: (value) {
                    try {
                      amount = int.parse(value);
                    } catch (e) {
                      Fluttertoast.showToast(
                          msg: 'Please Enter Numbers Only',
                          backgroundColor: Colors.grey);
                    }
                  },
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15.0,
          ),
          const SizedBox(
            height: 15.0,
          ),
          Row(
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: appThemeColor,
                      borderRadius: BorderRadius.circular(16.0)),
                  padding: const EdgeInsets.all(12.0),
                  child: const Icon(
                    Icons.category,
                    color: Colors.white,
                  )),
              const SizedBox(
                width: 15.0,
              ),
              ChoiceChip(
                label: Text(
                  'Income',
                  style: TextStyle(
                      fontSize: 16.0,
                      color: type == "income" ? Colors.white : Colors.black),
                ),
                selected: type == "income" ? true : false,
                selectedColor: appThemeColor,
                onSelected: (value) {
                  setState(() {
                    type = "income";
                  });
                },
              ),
              const SizedBox(
                width: 15.0,
              ),
              ChoiceChip(
                label: Text(
                  'Expense',
                  style: TextStyle(
                      fontSize: 16.0,
                      color: type == "expense" ? Colors.white : Colors.black),
                ),
                selected: type == "expense" ? true : false,
                selectedColor: appThemeColor,
                onSelected: (value) {
                  setState(() {
                    type = "expense";
                  });
                },
              ),
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          TextButton(
              onPressed: () {
                selectDate(context);
              },
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.all(0))),
              child: Row(
                children: [
                  Container(
                      decoration: BoxDecoration(
                          color: appThemeColor,
                          borderRadius: BorderRadius.circular(16.0)),
                      padding: const EdgeInsets.all(12.0),
                      child: const Icon(
                        Icons.calendar_month_outlined,
                        color: Colors.white,
                      )),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Text(
                    "${selectedDate.day}  ${months[selectedDate.month - 1]}  ${selectedDate.year}",
                    style: const TextStyle(
                        fontSize: 15.0,
                        color: Color.fromRGBO(100, 100, 100, 1)),
                  ),
                ],
              )),
          const SizedBox(
            height: 20.0,
          ),
          Row(
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: appThemeColor,
                      borderRadius: BorderRadius.circular(16.0)),
                  padding: const EdgeInsets.all(12.0),
                  child: const Icon(
                    Icons.notes,
                    color: Colors.white,
                  )),
              const SizedBox(
                width: 15.0,
              ),
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                      hintText: 'Notes', border: InputBorder.none),
                  style: const TextStyle(fontSize: 16.0),
                  onChanged: (value) {
                    note = value;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          SizedBox(
            height: 40.0,
            child: ElevatedButton(
                onPressed: () {
                  if (amount != null && note!='' && type.isNotEmpty) {
                    Dbhelper dbhelper = Dbhelper();
                    dbhelper.addData(
                      amount!,
                      '${selectedDate.day} ${months[selectedDate.month - 1]}  ${selectedDate.year}',
                      note,
                      type,
                      selectedDate,
                    );
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                      builder: (ctx3){return const HomeScreen();}),(route)=>false);
                       AnimatedSnackBar.material(
                              'Added Successfully',
                              mobileSnackBarPosition: MobileSnackBarPosition.bottom,
                              duration:const Duration(seconds: 3),
                              type: AnimatedSnackBarType.success)
                          .show(context);
                  }else{
                     AnimatedSnackBar.material(
                              'Please fill all details',
                              duration:const Duration(seconds: 3),
                              
                              type: AnimatedSnackBarType.error)
                          .show(context);
                  }
                  

                      
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: appThemeColor,
                    textStyle: const TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.w400)),
                child: const Text('Add')),
          ),
        ],
      ),
    );
  }
}
