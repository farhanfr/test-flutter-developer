part of 'watchlist_favourite_movies_bloc.dart';

 class WatchlistFavouriteMoviesEvent extends Equatable {
  const WatchlistFavouriteMoviesEvent();

  @override
  List<Object> get props => [];
}

class OnWatchlistMovie extends WatchlistFavouriteMoviesEvent {
  OnWatchlistMovie(this.page);
  final int page;

  @override
  List<Object> get props => [page];
}

class OnFavouriteMovie extends WatchlistFavouriteMoviesEvent {
  OnFavouriteMovie(this.page);
  final int page;

  @override
  List<Object> get props => [page];
}
