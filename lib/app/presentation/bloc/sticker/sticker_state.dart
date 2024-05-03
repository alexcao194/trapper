part of 'sticker_bloc.dart';

class StickerState extends Equatable {
  final List<StickerData> stickers;
  const StickerState({this.stickers = const []});

  @override
  List<Object?> get props => [stickers];

  StickerState copyWith({List<StickerData>? stickers}) {
    return StickerState(stickers: stickers ?? this.stickers);
  }
}
