import 'dart:io';

import 'package:dio/dio.dart';
import 'package:test_flutter_developer_enterkomputer/data/models/models.dart';
import 'package:test_flutter_developer_enterkomputer/helper/helper.dart';
import 'package:get_storage/get_storage.dart';
import 'package:test_flutter_developer_enterkomputer/main.dart';

class AuthRepository {
  final ApiProvider _api = ApiProvider();
  final gs = GetStorage();
  Dio dio = Dio();

  final String apiKey = Config.apiKey;

  Future<void> login(String username, String password) async {
    final reqToken =
        await _api.get("/authentication/token/new?api_key=$apiKey", headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    if (reqToken.statusCode == 200) {
      final reqSessionLogin = await _api.post(
          "/authentication/token/validate_with_login?api_key=$apiKey",
          isRawBody: true,
          body: {
            "username": username,
            "password": password,
            "request_token": reqToken.data['request_token'],
          },
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          });
      if (reqSessionLogin.statusCode == 200) {
        final createSessionId = await _api.post(
            "/authentication/session/new?api_key=$apiKey",
            isRawBody: true,
            body: {
              "request_token": reqSessionLogin.data['request_token'],
            },
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
            });
        if (createSessionId.statusCode == 200) {
          saveSession(createSessionId.data['session_id']);
        } else {
          throw createSessionId.data['status_message'];
        }
      } else {
        throw reqSessionLogin.data['status_message'];
      }
    }
  }

  Future<FetchUserDataResponse> fetchProfileUser() async {
    final response = await _api.get(
        "/account/8927813?api_key=$apiKey&session_id=${getSession()}",
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        });

    Map<String, dynamic> data = {};

    if (response.statusCode == 200) {
      data = {"data": response.data};
    } else {
      deleteSession();
      if (response.data['status_code'] == 3) {
        throw "Session expired, please login again";
      }
    }

    return FetchUserDataResponse.fromJson(data);
  }

  Future<void> logout() async {
  final response =  await _api.delete("/authentication/session?api_key=$apiKey", body: {
      "session_id": getSession()
    }, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    if (response.statusCode == 200) {
      deleteSession();
    }
  }

  void deleteSession() {
    gs.remove('sessionId');
  }

  void saveSession(String sessionId) {
    gs.write('sessionId', sessionId);
  }

  bool hasSession() {
    return gs.read('sessionId') == null ? false : true;
  }

  String getSession() {
    return gs.read('sessionId').toString();
  }
}
