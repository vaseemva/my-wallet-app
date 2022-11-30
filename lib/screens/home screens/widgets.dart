import 'package:flutter/material.dart';

Widget noDataHome(){
  return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/nodatahome.gif',
                      height: 350,
                    ),
                    const Text(
                      "Add a transaction to get started...",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                );
}