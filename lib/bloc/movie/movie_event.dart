part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();
}

class GetMovie extends MovieEvent {
  const GetMovie();

  @override
  List<Object> get props => [];
}

class AddMovieEvent extends MovieEvent {
  final String movieName;
  final String directorName;
  final File posterImg;
  final BuildContext context;

  @override
  List<Object> get props => [String,String, File, BuildContext];

  const AddMovieEvent(
      {required this.movieName,
      required this.directorName,
      required this.posterImg,
      required this.context});
}
