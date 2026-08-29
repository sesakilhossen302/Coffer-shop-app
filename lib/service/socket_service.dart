import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'api_url.dart';

class SocketService {
  io.Socket? _socket;

  bool get isConnected => _socket?.connected ?? false;

  void initSocket() {
    _socket = io.io(
      ApiUrl.socketUrl,
      io.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    _socket?.onConnect((_) {
      if (kDebugMode) print('Socket Connected');
    });

    _socket?.onDisconnect((_) {
      if (kDebugMode) print('Socket Disconnected');
    });

    _socket?.onError((err) {
      if (kDebugMode) print('Socket Error: $err');
    });
  }

  void connect() {
    _socket?.connect();
  }

  void disconnect() {
    _socket?.disconnect();
  }

  void emit(String event, dynamic data) {
    _socket?.emit(event, data);
  }

  void listen(String event, Function(dynamic data) callback) {
    _socket?.on(event, callback);
  }
}
