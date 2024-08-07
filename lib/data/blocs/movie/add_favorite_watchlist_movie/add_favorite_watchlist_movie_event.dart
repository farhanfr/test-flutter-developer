part of 'add_favorite_watchlist_movie_bloc.dart';

 class AddFavoriteWatchlistMovieEvent extends Equatable {
  const AddFavoriteWatchlistMovieEvent();

  @override
  List<Object> get props => [];
}

class OnAddFavorite extends AddFavoriteWatchlistMovieEvent {
  OnAddFavorite(this.movieId);
  final int movieId;

  @override
  List<Object> get props => [movieId];
}

class OnAddWatchlist extends AddFavoriteWatchlistMovieEvent {
  OnAddWatchlist(this.movieId);
  final int movieId;

  @override
  List<Object> get props => [movieId];
}