import 'package:flutter/material.dart';
import 'package:my_wallet_app/controllers/db_helper.dart';
import 'package:my_wallet_app/screens/home%20screens/home_screen.dart';
import '../introduction_screen/indroduction_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Dbhelper dbhelper = Dbhelper();

  Future getsettings() async {
    await Future.delayed(const Duration(seconds: 3));
    String? name = await dbhelper.getname();
    if (name != null) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()));
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const IndroduceScreen()));
    }
  }

  @override
  void initState() {
    super.initState();
    getsettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset(
                  appLogoPath,
                  height: 140.0,
                  width: 140.0,
                ))));
  }
}
