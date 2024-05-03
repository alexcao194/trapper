import 'package:flutter/material.dart';
import 'package:gif/gif.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Sticker extends StatefulWidget {
  final String src;
  const Sticker({super.key, required this.src});

  @override
  State<Sticker> createState() => _StickerState();
}

class _StickerState extends State<Sticker> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late GifController _controller;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Gif(
      image: AssetImage(widget.src),
      controller: _controller,
      autostart: Autostart.no,
      placeholder: (context) => Center(
        child: LoadingAnimationWidget.waveDots(
          color: Theme.of(context).colorScheme.primary,
          size: 20,
        ),
      ),
      fit: BoxFit.cover,
      repeat: ImageRepeat.repeat,
      onFetchCompleted: () {
        _controller.reset();
        _controller.repeat();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = GifController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
