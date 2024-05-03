import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entity/sticker.dart';
import '../../../domain/use_case/get_stickers.dart';

part 'sticker_event.dart';
part 'sticker_state.dart';

class StickerBloc extends Bloc<StickerEvent, StickerState> {
  late GetStickers _getStickers;
  List<StickerData> _stickers = [];
  StickerBloc({required GetStickers getStickers}) : super(const StickerState()) {
    _getStickers = getStickers;
    on<StickerUpdate>(_onStickerUpdate);
    on<StickerFilter>(_onStickerFilter);

    add(StickerUpdate(stickers: _getStickers()));
  }

  FutureOr<void> _onStickerUpdate(StickerUpdate event, Emitter<StickerState> emit) {
    _stickers = event.stickers;
    emit(state.copyWith(stickers: _stickers));
  }

  FutureOr<void> _onStickerFilter(StickerFilter event, Emitter<StickerState> emit) {
    var query = event.query.toLowerCase();
    final filteredStickers = _stickers.where((sticker) => sticker.slug.contains(query)).toList();
    emit(state.copyWith(stickers: filteredStickers));
  }
}
