import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:my_wallet_app/colors/colors.dart';
import 'package:my_wallet_app/controllers/db_helper.dart';
import 'package:my_wallet_app/screens/profile_name_screen/profile_name_screen.dart';

String appLogoPath = 'assets/images/mywalletalogo.png';

class IndroduceScreen extends StatefulWidget {
  const IndroduceScreen({super.key});

  @override
  State<IndroduceScreen> createState() => _IndroduceScreenState();
}

class _IndroduceScreenState extends State<IndroduceScreen> {
  Dbhelper dbhelper = Dbhelper();
  List<PageViewModel> getpages() {
    return [
      PageViewModel(
          image: Image.asset(
            'assets/images/tracktransaction.png',
            width: 500,
            height: 500,
          ),
          title: 'Everything You Need..!',
          body: 'Track all your transactions at one place',
          decoration: const PageDecoration(
              imagePadding: EdgeInsets.only(top: 80.0),
              bodyAlignment: Alignment.center)),
      PageViewModel(
          image: Center(
            child: Image.asset(
              'assets/images/graphical analysis.png',
              width: 500,
              height: 500,
            ),
          ),
          title: 'Easily Track Expenses',
          body: 'Get graphical analysis of your expenses',
          decoration: const PageDecoration(
              imagePadding: EdgeInsets.only(top: 80.0),
              bodyAlignment: Alignment.center)),
      PageViewModel(
          image: Center(
            child: Image.asset(
              'assets/images/plan.png',
              width: 500,
              height: 500,
            ),
          ),
          title: 'Planning is the key',
          body: 'Plan your life with the help from My wallet',
          decoration: const PageDecoration(
              imagePadding: EdgeInsets.only(top: 80.0),
              bodyAlignment: Alignment.center)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0.0, backgroundColor: appThemeColor),
      body: IntroductionScreen(
        globalBackgroundColor: Colors.white,
        showDoneButton: true,
        showSkipButton: true,
        showNextButton: true,
        next: const Text('Next'),
        done: const Text('Got it'),
        skip: const Text('Skip'),
        onDone: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => NameScreen()));
        },
        onSkip: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => NameScreen()));
        },
        pages: getpages(),
      ),
    );
  }
}
