import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';

import 'package:my_wallet_app/colors/colors.dart';
import 'package:my_wallet_app/controllers/db_helper.dart';
import 'package:my_wallet_app/screens/home%20screens/home_screen.dart';

import 'package:my_wallet_app/screens/profile_name_screen/widgets.dart';

class NameScreen extends StatelessWidget {
  NameScreen({super.key});
  final _namecontroller = TextEditingController();
  final Dbhelper dbhelper = Dbhelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(toolbarHeight: 0.0, backgroundColor: appThemeColor),
        backgroundColor: screenBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              logoImage(),
              const SizedBox(
                height: 12.0,
              ),
              const Text(
                'What should we call you?',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w800),
              ),
              const SizedBox(
                height: 12.0,
              ),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(18.0)),
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: TextField(
                    controller: _namecontroller,
                    decoration: const InputDecoration(
                        hintText: 'Your Name',
                        border: InputBorder.none,
                        counterText: ""),
                    maxLength: 12,
                  )),
              const SizedBox(
                height: 12.0,
              ),
              SizedBox(
                height: 50.0,
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () {
                    saveName(context);
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(appThemeColor)),
                  child: const Text(
                    "Let's Go",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  saveName(BuildContext context) {
    String name = _namecontroller.text;
    if (name.isNotEmpty) {
      dbhelper.addname(name);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()));
    } else {
      AnimatedSnackBar.material('Enter your name to get started',
              type: AnimatedSnackBarType.error)
          .show(context);
    }
  }
}
