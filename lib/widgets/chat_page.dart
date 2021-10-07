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
          name: "Jane Russel",
          messageText: "Awesome Setup",
          imageURL: "https://randomuser.me/api/portraits/women/1.jpg",
          time: "Now"),
      ChatUsers(
          name: "Glady's Murphy",
          messageText: "That's Great",
          imageURL: "https://randomuser.me/api/portraits/women/2.jpg",
          time: "Yesterday"),
      ChatUsers(
          name: "Jorge Henry",
          messageText: "Hey where are you?",
          imageURL: "https://randomuser.me/api/portraits/men/3.jpg",
          time: "31 Mar"),
      ChatUsers(
          name: "Philip Fox",
          messageText: "Busy! Call me in 20 mins",
          imageURL: "https://randomuser.me/api/portraits/men/4.jpg",
          time: "28 Mar"),
      ChatUsers(
          name: "Debra Hawkins",
          messageText: "Thankyou, It's awesome",
          imageURL: "https://randomuser.me/api/portraits/women/5.jpg",
          time: "23 Mar"),
      ChatUsers(
          name: "Jacob Pena",
          messageText: "will update you in evening",
          imageURL: "https://randomuser.me/api/portraits/men/6.jpg",
          time: "17 Mar"),
      ChatUsers(
          name: "Andrey Jones",
          messageText: "Can you please share the file?",
          imageURL: "https://randomuser.me/api/portraits/men/7.jpg",
          time: "24 Feb"),
      ChatUsers(
          name: "John Wick",
          messageText: "How are you?",
          imageURL: "https://randomuser.me/api/portraits/men/8.jpg",
          time: "18 Feb"),
      ChatUsers(
          name: "R R",
          messageText: "How are you?",
          imageURL: "https://randomuser.me/api/portraits/men/9.jpg",
          time: "18 Feb"),
      ChatUsers(
          name: "R R",
          messageText: "How are you?",
          imageURL: "https://randomuser.me/api/portraits/men/9.jpg",
          time: "18 Feb"),
      ChatUsers(
          name: "Qee R",
          messageText: "How are you?",
          imageURL: "https://randomuser.me/api/portraits/men/9.jpg",
          time: "18 Feb"),
      ChatUsers(
          name: "Seee R",
          messageText: "How are you?",
          imageURL: "https://randomuser.me/api/portraits/men/9.jpg",
          time: "18 Feb"),
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
