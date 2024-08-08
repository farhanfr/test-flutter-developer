import 'dart:io';

import 'package:dio/dio.dart';
import 'package:test_flutter_developer_enterkomputer/data/models/models.dart';
import 'package:test_flutter_developer_enterkomputer/helper/helper.dart';
import 'package:get_storage/get_storage.dart';
import 'package:test_flutter_developer_enterkomputer/main.dart';

class AuthRepository {
  /// Melakukan instansi pada class ApiProvider() yang telah dibuat
  final ApiProvider _api = ApiProvider();
  /// Melakukan instansi pada class GetStorage()
  final gs = GetStorage();
  /// Mendeklarasikan dan inisiasi variabel apiKey
  final String apiKey = Config.apiKey;

  /// Fungsi untuk melakukan login
  Future<void> login(String username, String password) async {
    /// Melakukan request pada endpoint dituju yaitu membuat request token
    final reqToken =
        await _api.get("/authentication/token/new?api_key=$apiKey", headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    /// Jika request token sukses, lakukan request pada endpoint dituju yaitu
    /// melakukan validasi dengan memasukkan username, password, dan request token TMDB
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
      /// Jika request session login sukses, lakukan request pada endpoint dituju yaitu
      /// membuat sessionId untuk user
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
        /// jika request sukses , maka simpan session id pada penyimpanan local
        if (createSessionId.statusCode == 200) {
          saveSession(createSessionId.data['session_id']);
        } else {
        /// Jika gagal maka kembalikan message error
          throw createSessionId.data['status_message'];
        }
      } else {
        throw reqSessionLogin.data['status_message'];
      }
    }
  }

 /// Fungsi untuk mengambil data profil user
  Future<FetchUserDataResponse> fetchProfileUser() async {
    /// melakukan request pada endpoint dituju yaitu mengambil data user
    final response = await _api.get(
        "/account/8927813?api_key=$apiKey&session_id=${getSession()}",
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        });

    /// melakukan deklarasi variabel dengan tibe object
    Map<String, dynamic> data = {};

    /// Jika request sukses, lakukan pengisian variabel data
    if (response.statusCode == 200) {
      data = {"data": response.data};
    } else {
      /// Jika request gagal, lakukan delete sessionId pada penyimpanen local
      deleteSession();
      if (response.data['status_code'] == 3) {
        throw "Session expired, please login again";
      }
    }

    /// lakukan return data pada class FetchUserDataResponse
    return FetchUserDataResponse.fromJson(data);
  }

 /// Fungsi untuk melakukan logout
  Future<void> logout() async {
    /// Melakukan request pada endpoint dituju yaitu menghapus session pada server
  final response =  await _api.delete("/authentication/session?api_key=$apiKey", body: {
      "session_id": getSession()
    }, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    /// Jika request sukses, lakukan delete sessionId pada penyimpanen local
    if (response.statusCode == 200) {
      deleteSession();
    }
  }

  /// Fungsi untuk menghapus sessionId pada penyimpanan local
  void deleteSession() {
    gs.remove('sessionId');
  }

  /// Fungsi untuk menyimpan sessionId pada penyimpanan local
  void saveSession(String sessionId) {
    gs.write('sessionId', sessionId);
  }

  /// Fungsi untuk mengecek apakah ada sessionId atau tidak
  bool hasSession() {
    return gs.read('sessionId') == null ? false : true;
  }

  /// Fungsi untuk mengambil sessionId pada penyimpanan local
  String getSession() {
    return gs.read('sessionId').toString();
  }
}
