import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class CallService {
  late RTCPeerConnection _peerConnection;
  late MediaStream _localStream;
  late IO.Socket _socket;
  late MediaStream _remoteStream;

  Future<void> init() async {
    _socket = IO.io('stun.l.google.com:19302');
    await _createPeerConnection();
    _registerSocketEvents();
  }

  Future<void> _createPeerConnection() async {
    _peerConnection = await createPeerConnection({
      'iceServers': [
        {'url': 'stun:stun.l.google.com:19302'}
      ]
    });

    _peerConnection.onIceCandidate = (candidate) {
      if (candidate == null) {
        print('Got all ICE candidates.');
        return;
      }
      _socket.emit('candidate', {
        'candidate': candidate.candidate,
        'sdpMid': candidate.sdpMid,
        'sdpMLineIndex': candidate.sdpMlineIndex,
      });
    };

    _peerConnection.onAddStream = (stream) {
      print('Got remote stream: ${stream.id}');
      _remoteStream = stream;
    };

    _localStream = await navigator.mediaDevices.getUserMedia({
      'audio': true,
      'video': true,
    });

    _peerConnection.addStream(_localStream);
  }

  void _registerSocketEvents() {
    _socket.on('offer', (data) async {
      if (_peerConnection == null) {
        await _createPeerConnection();
      }
      await _peerConnection.setRemoteDescription(
          RTCSessionDescription(data['sdp'], data['type']));
      await _createAnswer();
    });

    _socket.on('answer', (data) async {
      await _peerConnection.setRemoteDescription(
          RTCSessionDescription(data['sdp'], data['type']));
    });

    _socket.on('candidate', (data) async {
      await _peerConnection.addCandidate(
        RTCIceCandidate(
          data['candidate'],
          data['sdpMid'],
          data['sdpMLineIndex'],
        ),
      );
    });
  }

  Future<void> startCall(String targetUserId) async {
    await _createOffer();
    _socket.emit('startCall', {'targetUserId': targetUserId});
  }

  Future<void> endCall(String targetUserId) async {
    _peerConnection.close();
    _socket.emit('endCall', {'targetUserId': targetUserId});
  }

  Future<void> _createOffer() async {
    RTCSessionDescription description =
    await _peerConnection.createOffer({'offerToReceiveVideo': 1});

    await _peerConnection.setLocalDescription(description);

    _socket.emit('offer', {
      'sdp': description.sdp,
      'type': description.type,
    });
  }

  Future<void> _createAnswer() async {
    RTCSessionDescription description =
    await _peerConnection.createAnswer({'offerToReceiveVideo': 1});

    await _peerConnection.setLocalDescription(description);

    _socket.emit('answer', {
      'sdp': description.sdp,
      'type': description.type,
    });
  }
}
