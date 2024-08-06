part of 'fetch_movie_bloc.dart';

 class FetchMovieState extends Equatable {
  const FetchMovieState();
  
  @override
  List<Object> get props => [];
}

 class FetchMovieInitial extends FetchMovieState {}

 
class FetchMovieNowPlayingLoading extends FetchMovieState {}

class FetchMovieNowPlayingSuccess extends FetchMovieState {
  FetchMovieNowPlayingSuccess(this.movie);

  final List<Movie> movie;

  @override
  List<Object> get props => [movie];
}

class FetchMovieNowPlayingFailure extends FetchMovieState {
  final String message;

  FetchMovieNowPlayingFailure(this.message);

  @override
  List<Object> get props => [message];
}

///

class FetchMoviePopularLoading extends FetchMovieState {}

class FetchMoviePopularSuccess extends FetchMovieState {
  FetchMoviePopularSuccess(this.movie);

  final List<Movie> movie;

  @override
  List<Object> get props => [movie];
}

class FetchMoviePopularFailure extends FetchMovieState {
  final String message;

  FetchMoviePopularFailure(this.message);

  @override
  List<Object> get props => [message];
}


