import 'package:socket_io_client/socket_io_client.dart';
import 'package:trapper/config/dio/dio_tools.dart';

import '../../app/data/data_source/local_data.dart';
import '../../di.dart';

class AppSocket {
  const AppSocket._();

  static Socket? _socket;

  static Socket get socket {
    _socket ??= io(DioTools.currentBaseUrl, OptionBuilder()
        .setTransports(['websocket'])
        .setAuth({'access_token': DependencyInjection.sl<LocalData>().getToken() })
        .disableAutoConnect()
        .build());
    return _socket!;
  }
}