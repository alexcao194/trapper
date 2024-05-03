part of 'sticker_bloc.dart';

sealed class StickerEvent extends Equatable {
  const StickerEvent();
}

class StickerUpdate extends StickerEvent {
  final List<StickerData> stickers;
  const StickerUpdate({required this.stickers});

  @override
  List<Object?> get props => [stickers];
}

class StickerFilter extends StickerEvent {
  final String query;
  const StickerFilter({required this.query});

  @override
  List<Object?> get props => [query];
}