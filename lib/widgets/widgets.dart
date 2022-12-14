import 'package:flutter/material.dart';

import 'package:my_wallet_app/colors/colors.dart';

Widget incomeCard(String value) {
  return Row(
    children: [
      Container(
        decoration: BoxDecoration(
          color: Colors.white60,
          borderRadius: BorderRadius.circular(20.0),
        ),
        padding: const EdgeInsets.all(6.0),
        margin: const EdgeInsets.only(right: 8.0),
        child: const Icon(
          Icons.arrow_upward,
          size: 28.0,
          color: Color.fromARGB(255, 4, 118, 6),
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Income',
            style: TextStyle(fontSize: 14.0, color: Colors.white),
          ),
          Text(
            '₹ $value',
            style: const TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.w700,
                color: Colors.white),
            overflow: TextOverflow.visible,
          )
        ],
      )
    ],
  );
}

//
Widget expenseCard(String value) {
  return Row(
    children: [
      Container(
        decoration: BoxDecoration(
          color: Colors.white60,
          borderRadius: BorderRadius.circular(20.0),
        ),
        padding: const EdgeInsets.all(6.0),
        margin: const EdgeInsets.only(right: 8.0),
        child: const Icon(
          Icons.arrow_downward,
          size: 28.0,
          color: Color.fromARGB(255, 222, 6, 6),
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Expense',
            style: TextStyle(fontSize: 14.0, color: Colors.white),
          ),
          Text(
            '₹ $value',
            style: const TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.w700,
                color: Colors.white),
            overflow: TextOverflow.ellipsis,
          )
        ],
      )
    ],
  );
}
//////////

Widget expenseTile(int amount, String note, String date) {
  return Container(
    margin: const EdgeInsets.all(4.0),
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
                  fontSize: 20.0,
                  fontWeight: FontWeight.w200,
                  color: Colors.white),
            )
          ],
        ),
      ],
    ),
  );
}

/////////////////
///
Widget incomeTile(int amount, String note, String date) {
  return Container(
    margin: const EdgeInsets.all(4.0),
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
              "+ ₹ $amount",
              style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w200,
                  color: Colors.white),
            )
          ],
        ),
      ],
    ),
  );
}

Widget settingsTile({
  required String title,
  required IconData icon,
}) {
  return Container(
    color: Colors.white,
    child: ListTile(
      leading: Icon(
        icon,
        size: 35.0,
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16.0),
      ),
    ),
  );
}
