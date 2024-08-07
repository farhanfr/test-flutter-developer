import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:test_flutter_developer_enterkomputer/utils/routes.dart';
import 'package:url_launcher/url_launcher.dart';

void hideKeyboard(context) {
  FocusScope.of(context).requestFocus(FocusNode());
}

void popUntilRoot(context) {
  Navigator.popUntil(context, ModalRoute.withName('/'));
}

void popScreen(BuildContext context, [dynamic data]) {
  Navigator.pop(context, data);
}

void pushAndRemoveScreen(BuildContext context, {@required Widget? pageRef}) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => pageRef!),
      (Route<dynamic> route) => false);
}

enum RouteTransition { slide, dualSlide, fade, material, cupertino, slideUp }

Future pushScreen(BuildContext context, Widget buildScreen,
    [RouteTransition routeTransition = RouteTransition.slide,
    Widget? fromScreen]) async {
  dynamic data;
  switch (routeTransition) {
    case RouteTransition.slide:
      data = await Navigator.push(context, SlideRoute(page: buildScreen));
      break;
    case RouteTransition.fade:
      data = await Navigator.push(context, FadeRoute(page: buildScreen));
      break;
    case RouteTransition.material:
      data = await Navigator.push(
          context, MaterialPageRoute(builder: (context) => buildScreen));
      break;
    case RouteTransition.dualSlide:
      data = await Navigator.push(
          context,
          DualSlideRoute(
              enterPage: buildScreen, exitPage: fromScreen ?? context.widget));
      break;
    case RouteTransition.cupertino:
      data = await Navigator.push(
          context,
          CupertinoPageRoute(
              fullscreenDialog: true, builder: (context) => buildScreen));
      break;
    case RouteTransition.slideUp:
      data = await Navigator.push(context, SlideUpRoute(page: buildScreen));
      break;
  }
  return data;
}

void showSnackbar(BuildContext context,
    {Color colors = Colors.black,
    String message = "THIS IS MESSAGE",
    int duration = 1,
    String label = "OK",
    Function()? onPressed}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: Duration(seconds: duration),
      backgroundColor: colors,
      behavior: SnackBarBehavior.floating,
      content: Text(
        message,
      ),
      action: onPressed == null ? null : SnackBarAction(label: label, onPressed: onPressed ?? () {}),
    ),
  );
}

Future<bool> hasConnection() async {
  final connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    return false;
  }
  return true;
}

String convertDateToDateStringFormatId(DateTime time) {
  var date = time.toUtc();
  var dateLocal = date.toLocal();
  return DateFormat("d MMMM yyyy", 'in_ID').format(dateLocal);
}

String convertDateToDateTimeStringFormatId(DateTime time) {
  var date = time.toUtc();
  var dateLocal = date.toLocal();
  return DateFormat("d MMMM yyyy HH:mm:ss", 'in_ID').format(dateLocal);
}

String convertDateToDateTimeMinuteStringFormatId(DateTime time) {
  var date = time.toUtc();
  var dateLocal = date.toLocal();
  return DateFormat("d-MM-yyyy HH:mm", 'in_ID').format(dateLocal);
}

String convertDateToTimeStringFormatId(DateTime time) {
  var date = time.toUtc();
  var dateLocal = date.toLocal();
  return DateFormat("HH:mm:ss", 'in_ID').format(dateLocal);
}

String convertDateToStringDayName(DateTime time) =>
    DateFormat("EEEE", 'in_ID').format(time);

Future<bool> requestPermission(Permission permission) async {
  if (await permission.isGranted) {
    return true;
  } else {
    var result = await permission.request();
    if (result == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }
}

// Future<List<String>> downloadImages(List<String> imageUrls) async {
//   List<String> localFilePaths = [];

//   for (String imageUrl in imageUrls) {
//     // Download image using Dio
//     Response<List<int>> response = await Dio().get<List<int>>(imageUrl,
//         options: Options(responseType: ResponseType.bytes));

//     // Get the app's temporary directory
//     Directory tempDir = await getTemporaryDirectory();
//     String tempPath = tempDir.path;

//     // Create a local file and write the image data to it
//     String localFilePath =
//         '$tempPath/${DateTime.now().millisecondsSinceEpoch}.jpg';
//     await File(localFilePath).writeAsBytes(response.data!);

//     // Add the local file path to the list
//     localFilePaths.add(localFilePath);
//   }

//   return localFilePaths;
// }

Future<void> toWebUrl(BuildContext context, String url) async {
  if (!await launch(url)) {
    // ignore: use_build_context_synchronously
   showSnackbar(context,message: "Url Tidak Valid");
  }
}


