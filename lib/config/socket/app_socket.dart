import 'package:socket_io_client/socket_io_client.dart';

import '../../app/data/data_source/local_data.dart';
import '../../di.dart';

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
        'extraHeaders': {'access_token': DependencyInjection.sl<LocalData>().getToken()},
      });
    return _socket!;
  }
}