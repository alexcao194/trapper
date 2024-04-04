import 'package:socket_io_client/socket_io_client.dart';

class AppSocket {
  const AppSocket._();

  static String get baseUrl {
    // return 'http://localhost:1904';
    return 'https://trapper-server.onrender.com';
  }

  static Socket? _socket;

  static Socket get socket {
    _socket ??= io(baseUrl, <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      });
    return _socket!;
  }
}