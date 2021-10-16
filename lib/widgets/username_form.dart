import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yam/widgets/password_form.dart';
import 'package:yam/widgets/register_form.dart';

class UsernameForm extends StatefulWidget {
  const UsernameForm({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return UsernameFormState();
  }
}

class UsernameFormState extends State<StatefulWidget> {
  final RegExp usernameRegExp = RegExp(r"^[a-z0-9]+$");

  final usernameController = TextEditingController(text: '');

  var hasError = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: CupertinoColors.activeGreen,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blue.shade200.withOpacity(0.7),
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Visibility(
                  // error flow
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  maintainInteractivity: false,
                  maintainSemantics: false,
                  visible: hasError,
                  child: Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    child: const TextField(
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        errorText:
                            'Only English lowercase letters and digits  allowed',
                        border: InputBorder.none,
                        errorMaxLines: 5,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                    color: CupertinoColors.systemGrey6,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: hasError
                        ? Border.all(color: Colors.red)
                        : Border.all(color: CupertinoColors.systemGrey6),
                  ),
                  child: TextField(
                    onChanged: (text) {
                      setState(() {
                        hasError = !usernameRegExp.hasMatch(text);
                      });
                    },
                    controller: usernameController,
                    textAlign: TextAlign.left,
                    decoration: const InputDecoration(
                      hintText: "Username",
                      hintStyle: TextStyle(color: Colors.black54),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                Visibility(
                  // error flow
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  maintainInteractivity: false,
                  maintainSemantics: false,
                  visible: !hasError,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    decoration: const BoxDecoration(
                      color: CupertinoColors.systemIndigo,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: TextButton(
                      onPressed: () async {
                        // search for existed user
                        var registeredUser = false;
                        FirebaseFirestore.instance
                            .collection('users')
                            .get()
                            .then((snapshot) {
                          snapshot.docs.forEach((element) {
                            var data = element.data();
                            if (data['username'] == usernameController.text) {
                              registeredUser = true;
                            }
                          });
                        });

                        var sharedPreferences =
                            await SharedPreferences.getInstance();
                        sharedPreferences.setString(
                          'username',
                          usernameController.text,
                        );

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return registeredUser
                                  ? const PasswordForm()
                                  : RegisterForm();
                            },
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.arrow_forward_outlined,
                        color: Colors.white70,
                      ),
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
