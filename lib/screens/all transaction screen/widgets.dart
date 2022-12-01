import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:my_wallet_app/controllers/db_helper.dart';
import 'package:my_wallet_app/screens/edit_transaction_screen/edit_transaction_screen.dart';

import '../../colors/colors.dart';
import '../home screens/home_screen.dart';

Dbhelper dbhelper = Dbhelper();
Widget noDataCard() {
  return Column(
    children: [
      Image.asset('assets/images/nodatafound.gif', width: 300, height: 300),
      const Text('No Data Found')
    ],
  );
}

Widget allTransactionExpenseTile(int amount, String note, String date,
    int index, String type, DateTime dateTime) {
  return Slidable(
    startActionPane: ActionPane(motion: const ScrollMotion(), children: [
      SlidableAction(
        onPressed: (BuildContext context) {
          delete(context, index);
        },
        borderRadius: BorderRadius.circular(20.0),
        backgroundColor: Colors.red,
        label: 'Delete',
        icon: Icons.delete,
      ),
      SlidableAction(
        onPressed: (BuildContext context) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => EditTransaction(
                  amount: amount,
                  note: note,
                  date: dateTime,
                  type: type,
                  index: index)));
        },
        borderRadius: BorderRadius.circular(20.0),
        backgroundColor: Colors.green,
        label: 'Edit',
        icon: Icons.edit,
      )
    ]),
    child: Container(
      margin: const EdgeInsets.all(7.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: appThemeColor, borderRadius: BorderRadius.circular(8.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.arrow_circle_down_outlined,
                    size: 40.0,
                    color: Colors.red[700],
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        note,
                        style: const TextStyle(
                            fontSize: 15.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        date,
                        style: const TextStyle(color: Colors.white),
                      )
                    ],
                  )
                ],
              ),
              Text(
                "- ₹ $amount",
                style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w200,
                    color: Colors.white),
              )
            ],
          ),
        ],
      ),
    ),
  );
}

Widget allTransactionIncomeTile(int amount, String note, String date, int index,
    String type, DateTime dateTime) {
  return Slidable(
    startActionPane: ActionPane(motion: const ScrollMotion(), children: [
      SlidableAction(
        onPressed: (BuildContext context) {
          delete(context, index);
        },
        borderRadius: BorderRadius.circular(20.0),
        backgroundColor: Colors.red,
        label: 'Delete',
        icon: Icons.delete,
      ),
      SlidableAction(
        onPressed: (BuildContext context) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => EditTransaction(
                  amount: amount,
                  note: note,
                  date: dateTime,
                  type: type,
                  index: index)));
        },
        borderRadius: BorderRadius.circular(20.0),
        backgroundColor: Colors.green,
        label: 'Edit',
        icon: Icons.edit,
      )
    ]),
    child: Container(
      margin: const EdgeInsets.all(7.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: appThemeColor, borderRadius: BorderRadius.circular(8.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.arrow_circle_up_outlined,
                    size: 40.0,
                    color: Colors.green[700],
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        note,
                        style: const TextStyle(
                            fontSize: 15.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        date,
                        style: const TextStyle(color: Colors.white),
                      )
                    ],
                  )
                ],
              ),
              Text(
                "- ₹ $amount",
                style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w200,
                    color: Colors.white),
              )
            ],
          ),
        ],
      ),
    ),
  );
}

void delete(ctx, index) {
  showDialog(
    context: ctx,
    builder: (context) {
      return AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text(
          'Do you really want to delete this transaction?',
          style: TextStyle(height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () {
              dbhelper.deleteData(index);
              AnimatedSnackBar.material(
                'Transaction deleted',
                duration: const Duration(seconds: 5),
                type: AnimatedSnackBarType.error,
                mobileSnackBarPosition: MobileSnackBarPosition
                    .bottom, // Position of snackbar on mobile devices
              ).show(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
            },
            child: const Text(
              'Yes',
              style: TextStyle(
                color: Color.fromARGB(255, 101, 209, 190),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'No',
              style: TextStyle(
                color: Color.fromARGB(255, 101, 209, 190),
              ),
            ),
          ),
        ],
      );
    },
  );
}
