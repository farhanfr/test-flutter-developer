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
      final MovieRepository movieRepository = MovieRepository();
      if (event is OnWatchlistMovie) {
        emit(WatchlistFavouriteMoviesLoading());
        final result = await movieRepository.fetchWatchlistMovieUser(
            currentPage: event.page);
        emit(WatchlistFavouriteMoviesSuccess(result.data));
      }
      if (event is OnFavouriteMovie) {
        emit(WatchlistFavouriteMoviesLoading());
        final result = await movieRepository.fetcFavouriteMovieUser(
            currentPage: event.page);
        emit(WatchlistFavouriteMoviesSuccess(result.data));
      }
    });
  }
}
