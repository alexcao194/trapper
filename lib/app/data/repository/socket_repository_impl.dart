import 'package:trapper/app/data/data_source/socket_data.dart';
import 'package:trapper/app/domain/entity/room_info.dart';

import '../../domain/repository/socket_repository.dart';

class SocketRepositoryImpl implements SocketRepository {
  late SocketData _socketData;
  SocketRepositoryImpl({required SocketData socketData}) {
    _socketData = socketData;
  }

  @override
  void connect() {
    _socketData.connect();
  }

  @override
  void disconnect() {
    _socketData.disconnect();
  }

  @override
  Stream<List<RoomInfo>> fetchRoomsInfo() {
    _socketData.sendMessage('on_fetch_rooms_info');
    return _socketData.roomsInfoStream.map((roomsInfo) => roomsInfo);
  }
}