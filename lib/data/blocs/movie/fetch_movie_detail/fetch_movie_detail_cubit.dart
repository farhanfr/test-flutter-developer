import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_flutter_developer_enterkomputer/data/models/models.dart';
import 'package:test_flutter_developer_enterkomputer/data/repositories/repositories.dart';

part 'fetch_movie_detail_state.dart';

class FetchMovieDetailCubit extends Cubit<FetchMovieDetailState> {
  FetchMovieDetailCubit() : super(FetchMovieDetailInitial());

  /// instansiasi movieRepository
  final MovieRepository _movieRepository = MovieRepository();

  /// Fungsi untuk mengambil data detail film
  Future<void> load({required int movieId}) async {
    /// ubah state menjadi FetchMovieDetailLoading
    emit(FetchMovieDetailLoading());
    try {
      /// jalankan fungsi fetchDetailMovie
      final response = await _movieRepository.fetchDetailMovie(movieId: movieId);
      /// jika sukses ubah state menjadi FetchMovieDetailSuccess dengan membawa argument data
      /// dari variabel response
      emit(FetchMovieDetailSuccess(response.data));
    } catch (error) {
      /// jika gagal ubah state menjadi FetchMovieDetailFailure dengan membawa argument error
      emit(FetchMovieDetailFailure(error.toString()));
    }
  }

}
