import 'package:flutter/material.dart';
import 'package:my_wallet_app/colors/colors.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> sendMail() async {
  final Uri url = Uri.parse(
      'mailto:vaseemanwarafi@gmail.com?subject=Feedback About My Wallet App&body=');
  if (!await launchUrl(url)) {
    throw 'Could not launch';
  }
}

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              'Privacy Policy',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'MyWallet is an app that makes it easier to analyse your spending and income. This application was my first flutter project. the source code is available on github; the URL is provided below: https://github.com/vaseemva/my-wallet-app',
                  textAlign: TextAlign.center,
                  style: TextStyle(height: 1.3),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: appThemeColor,
                    minimumSize: const Size(150, 40),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                child: const Text('OK'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AboutUsWidget extends StatelessWidget {
  const AboutUsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              'About Us',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          const SizedBox(height: 10),
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "I'm Vaseem Anwar, a growing flutter developer. This app is my first flutter project, and it can help you develop better financial habits. If you have any questions or comments, please get in touch with me. visit vaseemanwar.netlify.app, my website.",
                  textAlign: TextAlign.center,
                  style: TextStyle(height: 1.5),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 101, 209, 190),
                    minimumSize: const Size(150, 40),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                child: const Text('OK'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
