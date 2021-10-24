import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yam/widgets/home_page.dart';
import 'package:yam/widgets/register_form_field.dart';

class RegisterForm extends StatelessWidget {
  final usernameController = TextEditingController(text: '');
  final fullnameController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');
  final repeatPasswordController = TextEditingController(text: '');

  RegisterForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SharedPreferences.getInstance().then((value) {
      usernameController.text = value.getString('username')!;
    });

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
                RegisterFormField(
                  controller: usernameController,
                  hintText: "Username",
                  obscureText: false,
                ),
                const SizedBox(
                  height: 3,
                ),
                RegisterFormField(
                  controller: fullnameController,
                  hintText: "Fullname",
                  obscureText: false,
                ),
                const SizedBox(
                  height: 3,
                ),
                RegisterFormField(
                  controller: passwordController,
                  hintText: "Password",
                  obscureText: true,
                ),
                const SizedBox(
                  height: 3,
                ),
                RegisterFormField(
                  controller: repeatPasswordController,
                  hintText: "Repeat password",
                  obscureText: true,
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

                      var userDoc = FirebaseFirestore.instance
                          .collection('users')
                          .doc(usernameController.text);

                      userDoc.set({
                        'username': usernameController.text,
                        'password': passwordController.text,
                        'fullname': fullnameController.text
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
