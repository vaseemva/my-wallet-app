import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:my_wallet_app/colors/colors.dart';
import 'package:my_wallet_app/screens/splash_screen.dart';
import 'package:my_wallet_app/widgets/widgets.dart';

import '../controllers/db_helper.dart';

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
      appBar: AppBar(
        backgroundColor: appThemeColor,
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: Column(
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
            onTap: ()=>resetDialogue(),
          ),
          settingsTile(
            title: 'Privacy & Policy',
            icon: Icons.privacy_tip,
          ),
          settingsTile(
            title: 'Feedback',
            icon: Icons.message_outlined,
          ),
          settingsTile(
            title: 'About us',
            icon: Icons.people,
          ),
        ],
      ),
    );
  }


  Future changeNameDialogue() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text('Enter New Name'),
            content: TextField(
              decoration: const InputDecoration(hintText: 'New name'),
              onChanged: (value) {
                newName = value;
              },
            ),
            actions: [
              
              Row(
                children: [
                  TextButton(onPressed: (){
                    Navigator.of(context).pop();
                  }, child:const Text('Cancel')),
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
            content:const Text('This action will erase all of your data'),
            actions: [
              
              Row(
                children: [
                  TextButton(onPressed: (){
                    Navigator.of(context).pop();
                  }, child:const Text('No')),
                  TextButton(
                      onPressed: () {
                        
                          dbhelper.resetData();
                          dbhelper.resetSharedPreference();
                           
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>const SplashScreen()));
                         
                      
                      },
                      child: const Text('Yes')),
                ],
              )
                  
            ],
          ));
}
