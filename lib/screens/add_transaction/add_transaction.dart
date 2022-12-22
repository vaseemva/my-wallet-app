import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_wallet_app/colors/colors.dart';
import 'package:my_wallet_app/controllers/db_helper.dart';
import 'package:my_wallet_app/screens/add_transaction/widgets.dart';
import 'package:my_wallet_app/screens/home%20screens/home_screen.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  int? amount;
  String note = '';
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Column(
          children:const [
            SizedBox(height: 10.0,),
            Text(
              'Add Transaction',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SizedBox(
            height: 13.0,
          ),
          Row(
            children: [
              sympolContainer(Icons.notes),
              const SizedBox(
                width: 15.0,
              ),
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                      hintText: 'Title',
                      border: InputBorder.none,
                      counterText: ""),
                  style: const TextStyle(fontSize: 16.0),
                  onChanged: (value) {
                    note = value;
                  },
                  maxLength: 12,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30.0,
          ),
          Row(
            children: [
              sympolContainer(Icons.currency_rupee),
              const SizedBox(
                width: 15.0,
              ),
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                      hintText: '0', border: InputBorder.none, counterText: ""),
                  style: const TextStyle(fontSize: 20.0),
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
                  maxLength: 7,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30.0,
          ),
          Row(
            children: [
              sympolContainer(Icons.category),
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
                  sympolContainer(Icons.calendar_month_outlined),
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
          
          const SizedBox(
            height: 40.0,
          ),
          SizedBox(
            height: 40.0,
            child: ElevatedButton(
                onPressed: () {
                  onAddTransaction();
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

  onAddTransaction() {
    if (amount != null && note != '' && type.isNotEmpty) {
      Dbhelper dbhelper = Dbhelper();
      dbhelper.addData(
        amount!,
        '${selectedDate.day} ${months[selectedDate.month - 1]}  ${selectedDate.year}',
        note,
        type,
        selectedDate,
      );
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()));
      AnimatedSnackBar.material('Added Successfully',
              mobileSnackBarPosition: MobileSnackBarPosition.bottom,
              duration: const Duration(seconds: 3),
              type: AnimatedSnackBarType.success)
          .show(context);
    } else {
      AnimatedSnackBar.material('Please fill all details',
              duration: const Duration(seconds: 3),
              type: AnimatedSnackBarType.error)
          .show(context);
    }
  }
}
