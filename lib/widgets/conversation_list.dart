import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:yam/widgets/conversation_list_item.dart';
import 'package:http/http.dart' as http;

import 'models/chat_users_model.dart';

class ConversationList extends StatefulWidget {
  @override
  _ConversationListState createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  List<ChatUsers> chatUsers = [];

  void fetchUserList() async {
    final response =
        await http.get(Uri.parse('http://192.168.43.144:8080/api/user/list'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      //return Album.fromJson(jsonDecode(response.body));

      var json = jsonDecode(response.body);
      print(json);

      var userList = json['userInfos'] as List;
      userList.forEach((element) {});
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      //throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    print('INIT STATE!!!!');

    FirebaseFirestore.instance.collection('users').get().then((snapshot) {
      snapshot.docs.forEach((element) {
        var data = element.data();
        chatUsers.add(ChatUsers(
          id: data['username'],
          name: data['fullname'],
          messageText: "Не",
          imageURL: null,
          time: "Yesterday",
        ));

        setState(() {});
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var physics = const BouncingScrollPhysics()
        .applyTo(const AlwaysScrollableScrollPhysics());

    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
    final UniqueKey dissmissibleItemKey = UniqueKey();
    return Scaffold(
      key: scaffoldKey,
      body: RefreshIndicator(
        onRefresh: () async {
          chatUsers.clear();
          FirebaseFirestore.instance.collection('users').get().then((snapshot) {
            snapshot.docs.forEach((element) {
              var data = element.data();
              chatUsers.add(ChatUsers(
                id: data['username'],
                name: data['fullname'],
                messageText: "Не",
                imageURL: null,
                time: "Yesterday",
              ));
            });
          });

          return Future.delayed(const Duration(milliseconds: 500), () {
            print('The function that changees state');

            setState(() {});

            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                'updated',
                textAlign: TextAlign.center,
              ),
              duration: Duration(seconds: 1),
            ));
          });
        },
        child: SingleChildScrollView(
          physics: physics,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 30,
              ),
              ListView.builder(
                itemCount: chatUsers.length,
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 16),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: dissmissibleItemKey,
                    onDismissed: (direction) async {
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(chatUsers[index].id)
                          .delete();
                    },
                    confirmDismiss: (direction) {
                      return Future<bool?>(() {
                        return DismissDirection.endToStart == direction;
                      });
                    },
                    direction: DismissDirection.endToStart,
                    background: Container(color: Colors.red),
                    child: ConversationListItem(
                      id: chatUsers[index].id,
                      name: chatUsers[index].name,
                      messageText: chatUsers[index].messageText,
                      imageUrl: chatUsers[index].imageURL,
                      time: chatUsers[index].time,
                      isMessageRead: (index == 0 || index == 3) ? true : false,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
