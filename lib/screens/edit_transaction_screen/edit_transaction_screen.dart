import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../colors/colors.dart';
import '../../controllers/db_helper.dart';
import '../home screens/home_screen.dart';

class EditTransaction extends StatefulWidget {
  const EditTransaction(
      {super.key,
      required this.amount,
      required this.note,
      required this.date,
      required this.type,
      required this.index});

  final int amount;
  final String note;
  final DateTime date;
  final String type;
  final int index;

  @override
  State<EditTransaction> createState() => _EditTransactionState();
}

class _EditTransactionState extends State<EditTransaction> {
  TextEditingController editAmountController = TextEditingController();
  TextEditingController editNoteController = TextEditingController();
  @override
  void initState() {
    amount = widget.amount;
    note = widget.note;
    type = widget.type;
    selectedDate = widget.date;
    editAmountController.text = amount.toString();
    editNoteController.text = note;
    super.initState();
  }

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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: appThemeColor,
        title: const Text(
          'Edit Transaction',
          style: TextStyle(color: Colors.black),
        ),
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
                  controller: editAmountController,
                  onChanged: (value) {
                    amount = int.parse(value);
                  },
                  decoration: const InputDecoration(
                      hintText: '0', border: InputBorder.none),
                  style: const TextStyle(fontSize: 24.0),
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
                  controller: editNoteController,
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
                  updateTransaction();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: appThemeColor,
                    textStyle: const TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.w400)),
                child: const Text('Update')),
          ),
        ],
      ),
    );
  }

  updateTransaction() {
    if (amount != null && note != '' && type.isNotEmpty) {
      Dbhelper dbhelper = Dbhelper();
      dbhelper.updateData(
          amount,
          selectedDate,
          note,
          type,
          '${selectedDate.day} ${months[selectedDate.month - 1]}  ${selectedDate.year}',
          widget.index);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (ctx3) {
        return const HomeScreen();
      }), (route) => false);
      AnimatedSnackBar.material('Updated Successfully',
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
