import 'package:flutter/material.dart';
import 'package:yam/widgets/conversation_list.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConversationList(),
    );
  }
}
