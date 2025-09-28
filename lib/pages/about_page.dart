import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/app_images.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        backgroundColor: Colors.green,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: SizedBox(
            width: 400,
            child: Column(
              children: [
                // SizedBox(
                //   height: .22.sh,
                // ),
                const CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage(AppImages.profile),
                ),
                const Text(
                  'Ammar Ahmad',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Pacifico',
                  ),
                ),
                const Text(
                  'FLUTTER DEVELOPER',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const Divider(
                  height: 25,
                  color: Colors.grey,
                  indent: 100,
                  endIndent: 100,
                ),
                // 5.verticalSpace,
                const ListTile(
                  tileColor: Colors.white,
                  leading: Icon(Icons.email, color: Colors.green),
                  title: TextSelectionTheme(
                    data: TextSelectionThemeData(
                      selectionColor: Colors.grey,
                      selectionHandleColor: Colors.greenAccent,
                    ),
                    child: SelectableText(
                      'ammar.salim2018@gmail.com',
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
