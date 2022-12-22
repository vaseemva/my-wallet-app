import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:my_wallet_app/colors/colors.dart';
import 'package:my_wallet_app/screens/settings_screen/widgets.dart';
import 'package:my_wallet_app/screens/splash_screen/splash_screen.dart';
import 'package:my_wallet_app/widgets/widgets.dart';
import '../../controllers/db_helper.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final Dbhelper dbhelper = Dbhelper();
  String newName = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: appThemeColor,
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          GestureDetector(
            child: settingsTile(
              title: "Change Name",
              icon: Icons.person,
            ),
            onTap: () => changeNameDialogue(),
          ),
          GestureDetector(
            child: settingsTile(
              title: 'Reset App',
              icon: Icons.clear_all,
            ),
            onTap: () => resetDialogue(),
          ),
          InkWell(
            child: settingsTile(
              title: 'About us',
              icon: Icons.people,
            ),
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) => const AboutUsWidget());
            },
          ),
          InkWell(
              child: settingsTile(
                title: 'Feedback',
                icon: Icons.message_outlined,
              ),
              onTap: () {
                sendMail();
              }),
          InkWell(
            child: settingsTile(
              title: 'Privacy & Policy',
              icon: Icons.privacy_tip,
            ),
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) => const PrivacyPolicy());
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.36,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text(
                'Version',
                style: TextStyle(fontSize: 15),
              ),
              Text(
                '1.0.0',
                style: TextStyle(fontSize: 12),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future changeNameDialogue() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text('Enter New Name'),
            content: TextField(
              decoration:
                  const InputDecoration(hintText: 'New name', counterText: ""),
              maxLength: 15,
              onChanged: (value) {
                newName = value;
              },
            ),
            actions: [
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel')),
                  TextButton(
                      onPressed: () {
                        if (newName != '') {
                          dbhelper.addname(newName);
                          AnimatedSnackBar.material('Changed Successfully',
                              type: AnimatedSnackBarType.success);
                          Navigator.of(context).pop();
                        } else {
                          AnimatedSnackBar.material('Enter new name correctly',
                              type: AnimatedSnackBarType.error);
                        }
                      },
                      child: const Text('Save')),
                ],
              )
            ],
          ));

  Future resetDialogue() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text('Are you sure..?'),
            content: const Text('This action will erase all of your data'),
            actions: [
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('No')),
                  TextButton(
                      onPressed: () {
                        dbhelper.resetData();
                        dbhelper.resetSharedPreference();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const SplashScreen()));
                      },
                      child: const Text('Yes')),
                ],
              )
            ],
          ));
}
