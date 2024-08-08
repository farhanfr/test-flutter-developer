import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:test_flutter_developer_enterkomputer/data/models/models.dart';
import 'package:test_flutter_developer_enterkomputer/data/repositories/repositories.dart';
import 'package:test_flutter_developer_enterkomputer/helper/api_provider.dart';
import 'package:test_flutter_developer_enterkomputer/main.dart';

class MovieRepository {
  /// Melakukan instansi pada class ApiProvider() yang telah dibuat
  final ApiProvider _api = ApiProvider();

  /// Melakukan instansi pada class GetStorage()
  final gs = GetStorage();

  /// Mendeklarasikan dan inisiasi variabel apiKey
  final String apiKey = Config.apiKey;

  /// Melakukan instansi pada class AuthRepository()
  final AuthRepository _authRepository = AuthRepository();

  /// Fungsi untuk mengambil data detail film
  Future<FetchMovieResponse> fetchDetailMovie({required int movieId}) async {
    /// Melakukan request pada endpoint dituju yaitu mengambil data detail film
    final response =
        await _api.get("/movie/$movieId?api_key=$apiKey", headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    });

    /// melakukan deklarasi variabel dengan tibe object
    Map<String, dynamic> data = {};

    /// Jika request sukses, lakukan pengisian variabel data
    if (response.statusCode == 200) {
      data = {"data": response.data};
    } else {
      /// Jika request gagal, throw error dengan tulisan "Something when wrong"
      throw "Something when wrong";
    }

    /// lakukan return data pada class FetchMovieResponse
    return FetchMovieResponse.fromJson(data);
  }

  /// Fungsi untuk mengambil data similar film
  Future<FetchMovieListResponse> fetchSimilarMovie(
      {required int movieId}) async {
    /// Melakukan request pada endpoint dituju yaitu mengambil data similar film
    final response =
        await _api.get("/movie/$movieId/similar?api_key=$apiKey", headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    });

    /// Mendeklarasikan dan inisiasi variabel data dengan tipe object
    Map<String, dynamic> data = {};

    /// Jika request sukses, lakukan pengisian variabel data
    if (response.statusCode == 200) {
      data = {"data": response.data['results']};
    } else {
      /// Jika request gagal, throw error dengan tulisan "Something when wrong"
      throw "Something when wrong";
    }

    return FetchMovieListResponse.fromJson(data);
  }

  /// Fungsi untuk mengambil data watchlist film user
  Future<FetchMovieListResponse> fetchWatchlistMovieUser(
      {required int currentPage}) async {
    /// Melakukan request pada endpoint dituju yaitu mengambil data watchlist film
    final response = await _api.get(
        "/account/8927813/watchlist/movies?api_key=$apiKey&session_id=${_authRepository.getSession()}&page=$currentPage",
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        });

    ///  Mendeklarasikan dan inisiasi variabel data dengan tipe object
    Map<String, dynamic> data = {};

    /// Jika request sukses, lakukan pengisian variabel data
    if (response.statusCode == 200) {
      data = {"data": response.data['results']};
    } else {
      /// Jika request gagal, throw error dengan tulisan "Something when wrong"
      throw "Something when wrong";
    }

    /// lakukan return data pada class FetchMovieListResponse
    return FetchMovieListResponse.fromJson(data);
  }

  /// Fungsi untuk mengambil data favorit film user
  Future<FetchMovieListResponse> fetcFavouriteMovieUser(
      {required int currentPage}) async {
    /// Melakukan request pada endpoint dituju yaitu mengambil data favorit film
    final response = await _api.get(
        "/account/8927813/favorite/movies?api_key=$apiKey&session_id=${_authRepository.getSession()}&page=$currentPage",
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        });

    /// Mendeklarasikan dan inisiasi variabel data dengan tipe object
    Map<String, dynamic> data = {};

    /// Jika request sukses, lakukan pengisian variabel data
    if (response.statusCode == 200) {
      data = {"data": response.data['results']};
    } else {
      ///  Jika request gagal, throw error dengan tulisan "Something when wrong"
      throw "Something when wrong";
    }

    ///  lakukan return data pada class FetchMovieListResponse
    return FetchMovieListResponse.fromJson(data);
  }

  /// Fungsi untuk mengambil data film yang sedang tayang
  Future<FetchMovieListResponse> fetchNowPlayingMovie(
      {required int currentPage}) async {
    /// Melakukan request pada endpoint dituju yaitu mengambil data film yang sedang tayang
    final response = await _api
        .get("/movie/now_playing?api_key=$apiKey&page=$currentPage", headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    });

    /// Mendeklarasikan dan inisiasi variabel data dengan tipe object
    Map<String, dynamic> data = {};

    /// Jika request sukses, lakukan pengisian variabel data
    if (response.statusCode == 200) {
      data = {"data": response.data['results']};
    } else {
      ///  Jika request gagal, throw error dengan tulisan "Something when wrong"
      throw "Something when wrong";
    }

    return FetchMovieListResponse.fromJson(data);
  }

  /// Fungsi untuk mengambil data popular film
  Future<FetchMovieListResponse> fetchPopularMovie(
      {required int currentPage}) async {
    /// Melakukan request pada endpoint dituju yaitu mengambil data popular film
    final response = await _api
        .get("/movie/popular?api_key=$apiKey&page=$currentPage", headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    });

    ///  Mendeklarasikan dan inisiasi variabel data dengan tipe object
    Map<String, dynamic> data = {};

    /// Jika request sukses, lakukan pengisian variabel data
    if (response.statusCode == 200) {
      data = {"data": response.data['results']};
    } else {
      ///  Jika request gagal, throw error dengan tulisan "Something when wrong"
      throw "Something when wrong";
    }

    return FetchMovieListResponse.fromJson(data);
  }
}
