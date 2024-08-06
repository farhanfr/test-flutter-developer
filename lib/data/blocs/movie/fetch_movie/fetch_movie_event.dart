part of 'fetch_movie_bloc.dart';

class FetchMovieEvent extends Equatable {
  const FetchMovieEvent();

  @override
  List<Object> get props => [];
}

class OnNowPlayingMovie extends FetchMovieEvent {
  OnNowPlayingMovie(this.page);
  final int page;

  @override
  List<Object> get props => [page];
}

class OnPopularMovie extends FetchMovieEvent {
  OnPopularMovie(this.page);
  final int page;

  @override
  List<Object> get props => [page];
}

// class OnFavouriteMovie extends WatchlistFavouriteMoviesEvent {
//   OnFavouriteMovie(this.page);
//   final int page;

//   @override
//   List<Object> get props => [page];
// }
