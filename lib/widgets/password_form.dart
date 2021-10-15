import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yam/widgets/home_page.dart';

class PasswordForm extends StatelessWidget {
  const PasswordForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController loginController =
        TextEditingController(text: '');
    final TextEditingController passwordController =
        TextEditingController(text: '');
    return MaterialApp(
      color: CupertinoColors.activeGreen,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: CupertinoColors.lightBackgroundGray,
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  decoration: const BoxDecoration(
                    color: CupertinoColors.systemGrey6,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    textAlign: TextAlign.left,
                    decoration: const InputDecoration(
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.black54),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  decoration: const BoxDecoration(
                    color: CupertinoColors.systemIndigo,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) {
                            return const HomePage();
                          },
                        ),
                        (_) => false,
                      );

                      var sharedPreferences =
                          await SharedPreferences.getInstance();
                      sharedPreferences.setString(
                          'login', loginController.text);
                      sharedPreferences.setString(
                          'password', passwordController.text);

                      var doc =
                          FirebaseFirestore.instance.collection('users').doc();

                      doc.set({
                        'login': loginController.text,
                        'password': passwordController.text,
                      });
                    },
                    child: const Icon(
                      Icons.arrow_forward_outlined,
                      color: Colors.white70,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
