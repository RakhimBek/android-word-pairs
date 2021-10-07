import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class RtcConversation extends StatefulWidget {
  const RtcConversation({Key? key}) : super(key: key);

  @override
  RtcConversationState createState() => RtcConversationState();
}

class RtcConversationState extends State<RtcConversation> {
  final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  final RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();

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
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          var stream = await navigator.mediaDevices
              .getUserMedia({'video': true, 'audio': false});

          _localRenderer.srcObject = stream;
          _remoteRenderer.srcObject = await createLocalMediaStream('key');

          var peerConnection = await createPeerConnection(configuration);
          print(peerConnection != null);

          Navigator.push(context, MaterialPageRoute(builder: (context) {
            print('size !!!!!!! ' +
                MediaQuery.of(context).size.height.toString());
            print(
                'size !!!!!!! ' + MediaQuery.of(context).size.width.toString());

            var videoView = RTCVideoView(_localRenderer);
            var box = SizedBox(
              width: 200,
              height: 200,
              child: Container(child: videoView, color: Colors.green),
            );

            return Center(
              child: Draggable(
                child: box,
                feedback: box,
              ),
            );
          }));

          print('PRESS!!' + stream.id);
        },
        child: Text("CLICK ME!"),
      ),
    );
  }
}
