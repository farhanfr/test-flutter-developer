import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver_plus/gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:test_flutter_developer_enterkomputer/ui/widgets/custom_button.dart';
import 'package:test_flutter_developer_enterkomputer/ui/widgets/image_network_cached.dart';
import 'package:test_flutter_developer_enterkomputer/utils/colors.dart';
import 'package:test_flutter_developer_enterkomputer/utils/extensions.dart';
import 'package:path_provider/path_provider.dart';

class ProductDownloadImageScreen extends StatefulWidget {
  const ProductDownloadImageScreen({super.key, required this.pathImage});

  final String pathImage;

  @override
  State<ProductDownloadImageScreen> createState() =>
      _ProductDownloadImageScreenState();
}

class _ProductDownloadImageScreenState
    extends State<ProductDownloadImageScreen> {
  bool isLoading = false;
  String progressDownload = "0%";

  void _saveNetworkImage() async {
    setState(() {
      isLoading = true;
    });
    String path = 'https://image.tmdb.org/t/p/original${widget.pathImage}';
    await GallerySaver.saveImage(path).then((bool? successSave) {
      setState(() {
        setState(() {
          isLoading = false;
        });
        showSnackbar(context,
            message: "Image saved in gallery", colors: success);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Download Poster Movie"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: _screenWidth * (8 / 100), vertical: 15),
        child: Column(
          children: [
            ImageNetworkCached(
              image: "https://image.tmdb.org/t/p/original${widget.pathImage}",
              height: 500,
            ),
            CustomButton.contained(
                label: "Download",
                isLoading: isLoading,
                onPressed: () async {
                  _saveNetworkImage();
                }),
            // Visibility(visible: true, child: Text(progressDownload))
          ],
        ),
      ),
    );
  }
}
