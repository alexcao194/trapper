import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ImageMessage extends StatelessWidget {
  final String src;

  const ImageMessage({super.key, required this.src});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
          width: 2,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          cacheKey: src,
          imageUrl: src,
          placeholder: (context, url) => Center(
            child: LoadingAnimationWidget.waveDots(
              color: Theme.of(context).colorScheme.primary,
              size: 50,
            ),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
