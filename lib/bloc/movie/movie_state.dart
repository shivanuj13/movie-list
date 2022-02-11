part of 'movie_bloc.dart';

abstract class MovieState extends Equatable {
  const MovieState();
}

class MovieEmpty extends MovieState {
  const MovieEmpty();

  @override
  List<Object> get props => [];
}

class MovieLoading extends MovieState {
  const MovieLoading();

  @override
  List<Object> get props => [];
}

class MovieLoaded extends MovieState {
  final List<Movie>? movieList;
  const MovieLoaded(this.movieList);

  @override
  List<Object> get props => [Movie];
}

class MovieError extends MovieState {
  const MovieError();

  @override
  List<Object> get props => [];
}
