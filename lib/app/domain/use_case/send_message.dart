import '../entity/message_detail.dart';
import '../repository/socket_repository.dart';

class SendMessage {
  final SocketRepository _socketRepository;
  const SendMessage({required SocketRepository socketRepository}) : _socketRepository = socketRepository;

  void call({required String roomID, required MessageDetail message}) {
    _socketRepository.sendMessage(roomID: roomID, message: message);
  }
}