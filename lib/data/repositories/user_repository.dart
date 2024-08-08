import 'dart:io';

import 'package:test_flutter_developer_enterkomputer/data/repositories/repositories.dart';
import 'package:test_flutter_developer_enterkomputer/helper/helper.dart';
import 'package:test_flutter_developer_enterkomputer/main.dart';

class UserRepository {
  /// Melakukan instansi pada class ApiProvider() yang telah dibuat
  final ApiProvider _api = ApiProvider();

  /// Melakukan instansi pada class GetStorage()
  final String apiKey = Config.apiKey;

  /// Melakukan instansi pada class AuthRepository()
  final AuthRepository _authRepository = AuthRepository();

  /// Fungsi untuk melakukan add favorite film by user
  Future<void> addFavoriteByUser({required int movieId}) async {
    /// Melakukan request pada endpoint dituju yaitu menambahkan film favorit user
    await _api.post(
        "/account/8927813/favorite?api_key=$apiKey&session_id=${_authRepository.getSession()}",
        body: {
          'media_type': 'movie',
          'media_id': movieId,
          'favorite': true
        },
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        });
  }

  /// Fungsi untuk melakukan add watchlist film by user
  Future<void> addWatchlistByUser({required int movieId}) async {
    /// Melakukan request pada endpoint dituju yaitu menambahkan film watchlist user
    await _api.post(
        "/account/8927813/watchlist?api_key=$apiKey&session_id=${_authRepository.getSession()}",
        body: {
          'media_type': 'movie',
          'media_id': movieId,
          'watchlist': true
        },
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        });
  }
}
