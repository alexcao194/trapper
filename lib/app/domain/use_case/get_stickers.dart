import '../entity/sticker.dart';
import '../repository/static_repository.dart';

class GetStickers {
  final StaticRepository _staticRepository;
  
  GetStickers({required StaticRepository staticRepository}) : _staticRepository = staticRepository;
  
  List<StickerData> call() {
    return _staticRepository.getStickers();
  }
}