import 'package:flutter/material.dart';

import 'conversation.dart';

class ConversationListItem extends StatefulWidget {
  String id;
  String name;
  String messageText;
  String? imageUrl;
  String time;
  bool isMessageRead;

  ConversationListItem({
    required this.id,
    required this.name,
    required this.messageText,
    required this.imageUrl,
    required this.time,
    required this.isMessageRead,
  });

  @override
  _ConversationListItemState createState() =>
      _ConversationListItemState(id: id);
}

class _ConversationListItemState extends State<ConversationListItem> {
  String id;

  _ConversationListItemState({
    required this.id,
  });

  CircleAvatar getCircleAvatar() {
    print(widget.imageUrl);
    if (widget.imageUrl != null) {
      return CircleAvatar(
        backgroundImage: NetworkImage(widget.imageUrl!),
        maxRadius: 30,
      );
    }

    return CircleAvatar(
      child: Text(widget.name[0]),
      maxRadius: 30,
    );
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Conversation(id: this.id);
        }));
      },
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  getCircleAvatar(),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.name,
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            widget.messageText,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                              fontWeight: widget.isMessageRead
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              widget.time,
              style: TextStyle(
                fontSize: 12,
                fontWeight:
                    widget.isMessageRead ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
