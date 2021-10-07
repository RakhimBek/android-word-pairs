import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:yam/widgets/signaling.dart';

class RtcConversation extends StatefulWidget {
  const RtcConversation({Key? key}) : super(key: key);

  @override
  RtcConversationState createState() => RtcConversationState();
}

class RtcConversationState extends State<RtcConversation> {
  final Signaling signaling = Signaling();
  final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  final RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  String? roomId;
  TextEditingController textEditingController = TextEditingController(text: '');

  final Map<String, dynamic> configuration = {
    'iceServers': [
      {
        'urls': [
          'stun:stun1.l.google.com:19302',
          'stun:stun2.l.google.com:19302'
        ]
      },
      {'url': 'stun:stun2.1.google.com:19302'},
      {
        'urls': "turn:0.peerjs.com:3478",
        'username': "peerjs",
        'credential': "peerjsp"
      },
    ]
  };

  @override
  void initState() {
    _localRenderer.initialize();
    _remoteRenderer.initialize();

    signaling.onAddRemoteStream = ((stream) {
      _remoteRenderer.srcObject = stream;
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            SizedBox(height: 35),
            Row(children: [
              ElevatedButton(
                onPressed: () {
                  signaling.openUserMedia(_localRenderer, _remoteRenderer);
                  setState(() {});
                },
                child: Icon(
                  Icons.camera,
                  color: Colors.grey.shade600,
                  size: 20,
                ),
              ),
              SizedBox(
                width: 2,
              ),
              ElevatedButton(
                onPressed: () async {
                  roomId = await signaling.createRoom(_remoteRenderer);
                  textEditingController.text = roomId!;
                  setState(() {});
                },
                child: Text("Create room"),
              ),
              SizedBox(
                width: 2,
              ),
              ElevatedButton(
                onPressed: () {
                  // Add roomId
                  signaling.joinRoom(
                    textEditingController.text,
                    _remoteRenderer,
                  );
                },
                child: Text("Join room"),
              ),
              SizedBox(
                width: 2,
              ),
              ElevatedButton(
                onPressed: () {
                  signaling.hangUp(_localRenderer);
                  setState(() {});
                },
                child: Icon(
                  Icons.phone_disabled,
                  color: Colors.grey.shade600,
                  size: 20,
                ),
              ),
            ]),
          ],
        ),
        Expanded(
          child: Row(
              children: [
                Expanded(child: RTCVideoView(_localRenderer, mirror: true)),
                Expanded(child: RTCVideoView(_remoteRenderer)),
              ],
            ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Join the following Room: "),
              Flexible(
                child: TextFormField(
                  controller: textEditingController,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
