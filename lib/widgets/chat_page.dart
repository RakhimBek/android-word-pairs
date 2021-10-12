import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:yam/widgets/conversation_list.dart';
import 'package:http/http.dart' as http;

import 'models/chat_users_model.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
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
    chatUsers.addAll([
      ChatUsers(
          name: "Илья Годяев",
          messageText: "Ага",
          imageURL: "https://sun4-11.userapi.com/s/v1/if1/zuF1UsBOMZ5ApE1VB9EJFjWbZq7RXChRw_tXomSRB9DiH2tPYyZeqDUhhBmkHC-tO-UpaH2m.jpg?size=100x100&quality=96&crop=0,8,1010,1010&ava=1",
          time: "Yesterday"),
      ChatUsers(
          name: "Илья Симоненко",
          messageText: "Не",
          imageURL: "https://sun4-15.userapi.com/s/v1/if1/zZVazCrWYbV7PizVFpAYPTTXIbgqdDp9-7FE43BR6giGZeeGX4CHA_ioA71Bx8MN9Nab8ln5.jpg?size=100x100&quality=96&crop=285,184,1182,1182&ava=1",
          time: "Yesterday"),
      ChatUsers(
          name: "Раимбек Рахимбеков",
          messageText: "..",
          imageURL: "https://sun4-15.userapi.com/s/v1/ig2/gRyj33y7Ypu9s4qtQDOidCML_oAm1EPS7JN0XAHP0HO0Prtd1jtE-exlAT4dIB0ITWmSxcuMHxI_XRYrcLJYL3Ld.jpg?size=200x200&quality=96&crop=233,1,749,749&ava=1",
          time: "Yesterday"),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            ListView.builder(
              itemCount: chatUsers.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 16),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ConversationList(
                  name: chatUsers[index].name,
                  messageText: chatUsers[index].messageText,
                  imageUrl: chatUsers[index].imageURL,
                  time: chatUsers[index].time,
                  isMessageRead: (index == 0 || index == 3) ? true : false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
