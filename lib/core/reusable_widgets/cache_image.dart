import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../utils/cache_manager.dart';

const kPlaceHolder =
    'https://assets.goal.com/v3/assets/bltcc7a7ffd2fbf71f5/blt67a59125151d76ef/625e7dffceb10b47dfaba4dc/GettyImages-1348618431.jpg';

class ImageCacheR extends StatelessWidget {
  final double height, width, topRadius, topBottom, blend;
  final String image;
  final bool fit;
  final String? errorPlaceHolder;

  const ImageCacheR(
    this.image, {
    this.height = double.maxFinite,
    this.topRadius = 0,
    this.fit = true,
    this.blend = 0,
    this.errorPlaceHolder,
    this.topBottom = 0,
    this.width = double.maxFinite,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var radius = BorderRadius.only(
        topRight: Radius.circular(topRadius),
        topLeft: Radius.circular(topRadius),
        bottomLeft: Radius.circular(topBottom),
        bottomRight: Radius.circular(topBottom));

    return ClipRRect(
        borderRadius: radius,
        child: CachedNetworkImage(
          imageUrl: image,
          cacheManager: CustomCacheManager.instance,
          placeholder: (context, url) => Container(
            height: height,
            width: width,
            decoration:
                BoxDecoration(color: Colors.grey[300]!, borderRadius: radius),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
          height: height,
          width: width,
          key: UniqueKey(),
          filterQuality: FilterQuality.none,
          fadeInDuration: Duration.zero,
          fit: fit ? BoxFit.cover : BoxFit.scaleDown,
          repeat: ImageRepeat.repeat,
          colorBlendMode: BlendMode.darken,
          color: blend > 0 ? Colors.black.withOpacity(blend) : null,
          errorWidget: (context, url, error) => Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(errorPlaceHolder ??
                      'https://www.pulsecarshalton.co.uk/wp-content/uploads/2016/08/jk-placeholder-image.jpg'),
                  fit: fit ? BoxFit.cover : BoxFit.scaleDown),
              borderRadius: radius,
            ),
          ),
        ));
  }
}

class ImageCacheCircle extends StatelessWidget {
  final double height, width, topRadius, topBottom, blend;
  final String image;
  final bool fit;
  final String? errorPlaceHolder;

  const ImageCacheCircle(this.image,
      {this.height = double.maxFinite,
      this.topRadius = 10,
      this.fit = true,
      this.errorPlaceHolder,
      this.blend = 0,
      this.topBottom = 10,
      this.width = double.maxFinite,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var radius = BorderRadius.only(
        topRight: Radius.circular(topRadius),
        topLeft: Radius.circular(topRadius),
        bottomLeft: Radius.circular(topBottom),
        bottomRight: Radius.circular(topBottom));
    return CachedNetworkImage(
      height: height,
      width: width,
      placeholderFadeInDuration: Duration.zero,
      fadeInDuration: Duration.zero,
      cacheManager: CustomCacheManager.instance,
      imageUrl: image,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: imageProvider,
              fit: fit ? BoxFit.cover : BoxFit.scaleDown,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(blend), BlendMode.darken)),
        ),
      ),
      placeholder: (context, url) {
        return Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              color: Colors.white.withAlpha(170), borderRadius: radius),
        );
      },
      errorWidget: (context, url, error) {
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: AssetImage(errorPlaceHolder ??
                    'https://assets.goal.com/v3/assets/bltcc7a7ffd2fbf71f5/blt67a59125151d76ef/625e7dffceb10b47dfaba4dc/GettyImages-1348618431.jpg'),
                fit: BoxFit.cover),
          ),
        );
      },
    );
  }
}
