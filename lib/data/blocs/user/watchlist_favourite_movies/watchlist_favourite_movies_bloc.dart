import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_flutter_developer_enterkomputer/data/models/models.dart';
import 'package:test_flutter_developer_enterkomputer/data/repositories/movie_repository.dart';

part 'watchlist_favourite_movies_event.dart';
part 'watchlist_favourite_movies_state.dart';

class WatchlistFavouriteMoviesBloc
    extends Bloc<WatchlistFavouriteMoviesEvent, WatchlistFavouriteMoviesState> {
  WatchlistFavouriteMoviesBloc() : super(WatchlistFavouriteMoviesInitial()) {
    on<WatchlistFavouriteMoviesEvent>((event, emit) async {

      /// instance pada movieRepository
      final MovieRepository movieRepository = MovieRepository();
      /// jika event OnWatchlistMovie dipanggil
      if (event is OnWatchlistMovie) {
        /// ubah state menjadi WatchlistFavouriteMoviesLoading
        emit(WatchlistFavouriteMoviesLoading());
        /// jalankan fungsi fetchWatchlistMovieUser
        final result = await movieRepository.fetchWatchlistMovieUser(
            currentPage: event.page);
        /// jika sukses ubah state menjadi WatchlistFavouriteMoviesSuccess dengan membawa argument data 
        /// dari variabel result
        emit(WatchlistFavouriteMoviesSuccess(result.data));
      }

      /// jika event OnFavouriteMovie dipanggil
      if (event is OnFavouriteMovie) {
        /// ubah state menjadi WatchlistFavouriteMoviesLoading
        emit(WatchlistFavouriteMoviesLoading());
        /// jalankan fungsi fetcFavouriteMovieUser
        final result = await movieRepository.fetcFavouriteMovieUser(
            currentPage: event.page);
        /// jika sukses ubah state menjadi WatchlistFavouriteMoviesSuccess dengan membawa argument data
        /// dari variabel result
        emit(WatchlistFavouriteMoviesSuccess(result.data));
      }
    });
  }
}
