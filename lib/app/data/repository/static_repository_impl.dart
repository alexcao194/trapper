import '../../domain/entity/sticker.dart';
import '../../domain/repository/static_repository.dart';
import '../data_source/local_data.dart';

class StaticRepositoryImpl implements StaticRepository {
  final LocalData _localData;
  StaticRepositoryImpl({required LocalData localData}) : _localData = localData;

  @override
  List<StickerData> getStickers() {
    return _localData.getStickers();
  }
}