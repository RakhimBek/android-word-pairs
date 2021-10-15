import 'package:flutter/material.dart';
import 'package:yam/widgets/conversation_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConversationList(),
    );
  }
}
