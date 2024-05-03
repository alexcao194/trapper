import '../entity/sticker.dart';

abstract class StaticRepository {
  List<StickerData> getStickers();
}