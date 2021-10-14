import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:yam/widgets/rtc_conversation.dart';

import 'models/chat_message_model.dart';

class Conversation extends StatefulWidget {
  String id;

  Conversation({required this.id});

  @override
  _ConversationState createState() => _ConversationState(id);
}

class _ConversationState extends State<Conversation> {
  TextEditingController textEditingController = TextEditingController(text: '');
  List<ChatMessage> messages = [];

  String id;

  _ConversationState(this.id);

  @override
  void initState() {
    print('INIT STATE: ${id}');
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final chatCollection = db.collection('chat-collection');

    chatCollection.snapshots().listen((event) {
      event.docChanges.forEach((change) {
        var data = change.doc.data()!;
        if (change.type == DocumentChangeType.modified) {

          setState(() {
            var message = data;

            messages.add(ChatMessage(
              messageContent: message['content'],
              messageType: message['type'],
            ));
          });
        }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://sun4-11.userapi.com/s/v1/if1/zuF1UsBOMZ5ApE1VB9EJFjWbZq7RXChRw_tXomSRB9DiH2tPYyZeqDUhhBmkHC-tO-UpaH2m.jpg?size=100x100&quality=96&crop=0,8,1010,1010&ava=1"),
                  maxRadius: 20,
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Илья Годяев",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Online",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.settings,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          ListView.builder(
            itemCount: messages.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 10, bottom: 10),
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                padding:
                    EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
                child: Align(
                  alignment: (messages[index].messageType == "receiver"
                      ? Alignment.topLeft
                      : Alignment.topRight),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: (messages[index].messageType == "receiver"
                          ? Colors.grey.shade200
                          : Colors.blue[200]),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Text(
                      messages[index].messageContent,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextField(
                      controller: textEditingController,
                      decoration: InputDecoration(
                          hintText: "Write message...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        print('camera press');
                        return Scaffold(body: RtcConversation());
                      }));
                    },
                    icon: Icon(
                      Icons.photo_camera,
                      color: Colors.black,
                    ),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      final FirebaseFirestore db = FirebaseFirestore.instance;
                      final chatCollection = db.collection('chat-collection');
                      final doc = chatCollection.doc('chat');
                      doc.set({
                        'type': 'sender',
                        'content': textEditingController.text,
                      });
                      textEditingController.clear();
                    },
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
                    backgroundColor: Colors.blue,
                    elevation: 0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
