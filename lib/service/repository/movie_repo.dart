import 'dart:io';

import 'package:movies/models/movie_model.dart';

abstract class MovieRepo {
  void addMovie(String movieName, String directorName, File posterImg);
  Stream<List<Movie>?> fetchMovie();
  void deleteMovie(String docId, String imgUrl);
}
