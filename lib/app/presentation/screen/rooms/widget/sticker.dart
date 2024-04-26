import 'package:flutter/material.dart';
import 'package:gif/gif.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Sticker extends StatefulWidget {
  const Sticker({super.key});

  @override
  State<Sticker> createState() => _StickerState();
}

class _StickerState extends State<Sticker> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late GifController _controller;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Gif(
      image: const NetworkImage(
        'https://cors.sh/?https://cdn-stickers.mojilala.com/convert/4Yc/0W97kX5hyNZkT4vc21DnDN+2faE1Bk8Mt+qlLGDkARqwL/LYFQ8uRJF8RYmIlgOQb9krCurfbMU9JMD4LSI93UUFpQ8b5kMTJjH5tLaAN47zedWKuNt05n52XGuiastllgVXMd8s1Zq8l1RZfQ==.webp?v=1549878757',
      ),
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
