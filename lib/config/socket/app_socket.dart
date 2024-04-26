import 'package:socket_io_client/socket_io_client.dart';

import '../dio/dio_tools.dart';

class AppSocket {
  const AppSocket._();

  static Socket? _socket;

  static Socket get socket {
    _socket ??= io(
      DioTools.baseUrl,
      OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );
    return _socket!;
  }

  static void init(String token) {
    _socket = io(
      DioTools.baseUrl,
      OptionBuilder()
          .setTransports(['websocket'])
          .setAuth({'access_token': token})
          .disableAutoConnect()
          .build(),
    );
  }
}
