import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shimmer/shimmer.dart';
import 'package:test_flutter_developer_enterkomputer/utils/images.dart';


class ImageNetworkCached extends StatelessWidget {
  const ImageNetworkCached({
    Key? key,
    required this.image,
    this.height = 115,
    this.width = double.infinity,
    this.radius = 15,
    this.colorBlendMode = BlendMode.srcIn,
    this.color,
    this.boxfit = BoxFit.fill
  }) : super(key: key);

  final String image;
  final double height;
  final double width;
  final double radius;
  final BlendMode colorBlendMode;
  final Color? color;
  final BoxFit boxfit;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CachedNetworkImage(
        imageUrl: image,
        // memCacheHeight: Get.height.toInt() > 350
        //     ? (Get.height.toInt() * 0.25).toInt()
        //     : Get.height.toInt(),
        colorBlendMode: colorBlendMode,
        color: color,
        width: width,
        height: height,
        fit: boxfit,
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[200]!,
          period: Duration(milliseconds: 1000),
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius), color: Colors.white),
          ),
        ),
        errorWidget: (context, url, error) => Image.asset(
          img_error,
          width: width,
          height: height,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
