import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImageWidget extends StatelessWidget {
  final String? imageUrl;
   const CachedImageWidget({Key? key,this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return imageUrl != null
        ? CachedNetworkImage(
      imageUrl: imageUrl!,
      placeholder: (context, url) =>
          Center(child: const CircularProgressIndicator()),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    )
        : const SizedBox();
  }
}
