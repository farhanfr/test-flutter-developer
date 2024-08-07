part of 'fetch_movie_similar_cubit.dart';

class FetchMovieSimilarState extends Equatable {
  const FetchMovieSimilarState();

  @override
  List<Object> get props => [];
}

class FetchMovieSimilarInitial extends FetchMovieSimilarState {}

class FetchMovieSimilarLoading extends FetchMovieSimilarState {}

class FetchMovieSimilarSuccess extends FetchMovieSimilarState {
  FetchMovieSimilarSuccess(this.movie);

  final List<Movie> movie;

  @override
  List<Object> get props => [movie];
}

class FetchMovieSimilarFailure extends FetchMovieSimilarState {
  final String message;

  FetchMovieSimilarFailure(this.message);

  @override
  List<Object> get props => [message];
}
