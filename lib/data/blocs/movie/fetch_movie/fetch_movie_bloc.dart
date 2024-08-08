import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_flutter_developer_enterkomputer/data/models/models.dart';
import 'package:test_flutter_developer_enterkomputer/data/repositories/movie_repository.dart';

part 'fetch_movie_event.dart';
part 'fetch_movie_state.dart';

class FetchMovieBloc extends Bloc<FetchMovieEvent, FetchMovieState> {
  FetchMovieBloc() : super(FetchMovieInitial()) {
    /// melakukan instance pada movieRepository
    final MovieRepository movieRepository = MovieRepository();
    on<FetchMovieEvent>((event, emit) async {

    /// jika event OnNowPlayingMovie dipanggil
      if (event is OnNowPlayingMovie) {
        /// ubah state menjadi FetchMovieNowPlayingLoading
        emit(FetchMovieNowPlayingLoading());
        /// jalankan fungsi fetchNowPlayingMovie
        final result =
            await movieRepository.fetchNowPlayingMovie(currentPage: event.page);
        /// jika sukses ubah state menjadi FetchMovieNowPlayingSuccess
        emit(FetchMovieNowPlayingSuccess(result.data));
      }

      /// jika event OnPopularMovie dipanggil
      if (event is OnPopularMovie) {
        /// ubah state menjadi FetchMoviePopularLoading
        emit(FetchMoviePopularLoading());
        /// jalankan fungsi fetchPopularMovie
        final result =
            await movieRepository.fetchPopularMovie(currentPage: event.page);
        /// jika sukses ubah state menjadi FetchMoviePopularSuccess
        emit(FetchMoviePopularSuccess(result.data));
      }
    });
  }
}
