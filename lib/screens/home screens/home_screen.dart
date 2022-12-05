import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:my_wallet_app/colors/colors.dart';
import 'package:my_wallet_app/screens/add_transaction.dart';
import 'package:my_wallet_app/screens/all%20transaction%20screen/all_transaction_screen.dart';
import 'package:my_wallet_app/screens/graph_screen/graphscreen.dart';
import 'package:my_wallet_app/screens/home%20screens/home.dart';
import 'package:my_wallet_app/screens/settings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void navigatebottombar(int index) {
    setState(() {
      selectedindex = index;
    });
  }

  int selectedindex = 0;

  final List<Widget> pages = [
    const Home(),
    const AllTransactionScreen(),
    const AddTransaction(),
    const Graphscreen(),
    const Settings()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
        backgroundColor: appThemeColor,
      ),
      body: pages[selectedindex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
        child: GNav(
            onTabChange: (index) {
              navigatebottombar(index);
            },
            backgroundColor: appThemeColor,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.blueGrey.withOpacity(0.8),
            gap: 2,
            padding: const EdgeInsets.all(10.0),
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Home',
                iconSize: 30,
              ),
              GButton(
                icon: Icons.list,
                text: 'All',
                iconSize: 30,
              ),
              GButton(
                icon: Icons.add,
                text: 'Add',
                iconSize: 30,
              ),
              GButton(
                icon: Icons.bar_chart,
                text: 'Graphs',
                iconSize: 30,
              ),
              GButton(
                icon: Icons.settings,
                text: 'Settings',
                iconSize: 30,
              )
            ]),
      ),
    );
  }
}
