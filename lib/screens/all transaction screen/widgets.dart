import 'package:flutter/cupertino.dart';

Widget noDataCard() {
  return Column(
    children: [
      Image.asset('assets/images/nodatafound.gif', width: 300, height: 300),
      const Text('No Data Found')
    ],
  );
}
