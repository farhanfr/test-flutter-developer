import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:test_flutter_developer_enterkomputer/main.dart';
import 'package:test_flutter_developer_enterkomputer/utils/extensions.dart';

class ApiProvider {
  Dio dio = Dio();

  final String baseUrl = Config.baseUrl;

  Future<dynamic> get(dynamic path,
      {String? baseUrlCustom, required Map<String, dynamic> headers}) async {
    if (await hasConnection()) {
      final response = await dio.get(
          baseUrlCustom != null ? baseUrlCustom + path : baseUrl + path,
          options: Options(headers: headers, validateStatus: (status) => true));
      if (kDebugMode) {
        String responseJsonStr = response.data.toString();
        String endpointPath = response.requestOptions.path.toString();
        String endpointMethod = response.requestOptions.method.toString();

        debugPrint('\x1B[31m\n->\x1B[0m');
        debugPrint('\x1B[32m[$endpointMethod] $endpointPath\x1B[0m');
        debugPrint('\x1B[33m$responseJsonStr\x1B[0m');
      }
      return response;
      // switch (response.statusCode) {
      //   case 200:
      //     return response;
      //   case 401:
      //     throw response.data['message'];
      //   case 404:
      //     throw "Terjadi kesalahan [404]";
      //   case 500:
      //     throw "Terjadi kesalahan pada server [500]";
      //   default:
      // }
    } else {
      throw "koneksi_tidak_ditemukan";
    }
  }
  

  Future<dynamic> post(dynamic path,
      {required Map<String, dynamic> body,
      required Map<String, dynamic> headers,
      bool isRawBody = false}) async {
    if (await hasConnection()) {
      var formBody;
      if (isRawBody) {
        formBody = body;
      } else {
        formBody = FormData.fromMap(body);
      }

      final response = await dio.post(baseUrl + path,
          data: formBody,
          options: Options(headers: headers, validateStatus: (status) => true));
      if (kDebugMode) {
        String responseJsonStr = response.data.toString();
        String endpointPath = response.requestOptions.path.toString();
        String endpointMethod = response.requestOptions.method.toString();
        
        debugPrint('\x1B[31m\n->\x1B[0m');
        debugPrint('\x1B[32m[$endpointMethod] $endpointPath\x1B[0m');
        debugPrint('\x1B[33m$responseJsonStr\x1B[0m');
      }

      return response;
      // switch (response.statusCode) {
      //   case 200:
      //     return response;
      //   case 401:
      //     throw response.data['errors']['message'];
      //   case 422:
      //     throw response.data['errors']['message'];
      //   case 404:
      //     throw "Terjadi kesalahan [404]";
      //   case 500:
      //     throw "Terjadi kesalahan pada server [500]";
      //   default:
      // }
    } else {
      throw "koneksi_tidak_ditemukan";
    }
  }

  Future<dynamic> postArray(dynamic path,
      {required List<dynamic> body,
      required Map<String, dynamic> headers,
      bool isRawBody = false}) async {
    if (await hasConnection()) {
      var formBody = body;
      
      // if (isRawBody) {
      //   formBody = body;
      // } else {
      //   formBody = FormData.fromMap(body);
      // }

      final response = await dio.post(baseUrl + path,
          data: formBody,
          options: Options(headers: headers, validateStatus: (status) => true));
      if (kDebugMode) {
        String responseJsonStr = response.data.toString();
        String endpointPath = response.requestOptions.path.toString();
        String endpointMethod = response.requestOptions.method.toString();
        
        debugPrint('\x1B[31m\n->\x1B[0m');
        debugPrint('\x1B[32m[$endpointMethod] $endpointPath\x1B[0m');
        debugPrint('\x1B[33m$responseJsonStr\x1B[0m');
      }
      switch (response.statusCode) {
        case 200:
          return response.data;
        case 401:
          throw response.data['errors']['message'];
        case 422:
          throw response.data['errors']['message'];
        case 404:
          throw "Terjadi kesalahan [404]";
        case 500:
          throw "Terjadi kesalahan pada server [500]";
        default:
      }
    } else {
      throw "koneksi_tidak_ditemukan";
    }
  }

  Future<dynamic> put(dynamic path,
      {required Map<String, dynamic> body,
      required Map<String, dynamic> headers,
      bool isRawBody = false}) async {
    if (await hasConnection()) {
      var formBody;
      if (isRawBody) {
        formBody = body;
      } else {
        formBody = FormData.fromMap(body);
      }

      final response = await dio.put(baseUrl + path,
          data: formBody,
          options: Options(headers: headers, validateStatus: (status) => true));
      if (kDebugMode) {
        String responseJsonStr = response.data.toString();
        String endpointPath = response.requestOptions.path.toString();
        String endpointMethod = response.requestOptions.method.toString();

        // debugPrint('\x1B[31m\n->\x1B[0m');
        // debugPrint('\x1B[32m[$endpointMethod] $endpointPath\x1B[0m');
        // debugPrint('\x1B[33m$responseJsonStr\x1B[0m');
      }
      switch (response.statusCode) {
        case 200:
          return response.data;
        case 401:
          throw response.data['errors']['message'];
        case 422:
          throw response.data['errors'][0]['msg'];
        case 404:
          throw "Terjadi kesalahan [404]";
        case 500:
          throw "Terjadi kesalahan pada server [500]";
        default:
      }
    } else {
      throw "koneksi_tidak_ditemukan";
    }
  }

  Future<dynamic> patch(dynamic path,
      {required Map<String, dynamic> body,
      required Map<String, dynamic> headers,
      bool isRawBody = false}) async {
    if (await hasConnection()) {
      var formBody;
      if (isRawBody) {
        formBody = body;
      } else {
        formBody = FormData.fromMap(body);
      }

      final response = await dio.patch(baseUrl + path,
          data: formBody,
          options: Options(headers: headers, validateStatus: (status) => true));
      if (kDebugMode) {
        String responseJsonStr = response.data.toString();
        String endpointPath = response.requestOptions.path.toString();
        String endpointMethod = response.requestOptions.method.toString();

        // debugPrint('\x1B[31m\n->\x1B[0m');
        // debugPrint('\x1B[32m[$endpointMethod] $endpointPath\x1B[0m');
        // debugPrint('\x1B[33m$responseJsonStr\x1B[0m');
      }
      switch (response.statusCode) {
        case 200:
          return response.data;
        case 401:
          throw response.data['errors']['message'];
        case 422:
          throw response.data['errors'][0]['msg'];
        case 404:
          throw "Terjadi kesalahan [404]";
        case 500:
          throw "Terjadi kesalahan pada server [500]";
        default:
      }
    } else {
      throw "koneksi_tidak_ditemukan";
    }
  }

  Future<dynamic> delete(dynamic path,
      {required Map<String, dynamic> body,
      required Map<String, dynamic> headers,
      bool isRawBody = false}) async {
    if (await hasConnection()) {
      var formBody;
      if (isRawBody) {
        formBody = body;
      } else {
        formBody = FormData.fromMap(body);
      }

      final response = await dio.delete(baseUrl + path,
          data: formBody,
          options: Options(headers: headers, validateStatus: (status) => true));
      if (kDebugMode) {
        String responseJsonStr = response.data.toString();
        String endpointPath = response.requestOptions.path.toString();
        String endpointMethod = response.requestOptions.method.toString();
        
        debugPrint('\x1B[31m\n->\x1B[0m');
        debugPrint('\x1B[32m[$endpointMethod] $endpointPath\x1B[0m');
        debugPrint('\x1B[33m$responseJsonStr\x1B[0m');
      }

      return response;
      // switch (response.statusCode) {
      //   case 200:
      //     return response;
      //   case 401:
      //     throw response.data['errors']['message'];
      //   case 422:
      //     throw response.data['errors']['message'];
      //   case 404:
      //     throw "Terjadi kesalahan [404]";
      //   case 500:
      //     throw "Terjadi kesalahan pada server [500]";
      //   default:
      // }
    } else {
      throw "koneksi_tidak_ditemukan";
    }
  }
}
