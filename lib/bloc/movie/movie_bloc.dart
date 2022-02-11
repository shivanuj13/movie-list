import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:movies/models/movie_model.dart';
import 'package:movies/service/api/movie_api.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieApi _movieApi = MovieApi();
  StreamSubscription? _movieSubscription;
  MovieBloc() : super(const MovieLoading()) {
    on<GetMovie>((event, emit) async {
      emit(const MovieLoading());
      await emit.onEach(_movieApi.fetchMovie(),
          onData: (List<Movie>? movieList) {
        if (movieList!.isEmpty) {
          emit(const MovieEmpty());
        } else {
          emit(MovieLoaded(movieList));
        }
      });
    });
    _movieSubscription = _movieApi.fetchMovie().listen((event) {
      add(const GetMovie());
    });
    on<AddMovieEvent>((event, emit) async {
      emit(const MovieLoading());
      await _movieApi.addMovie(
          event.movieName, event.directorName, event.posterImg);
      Navigator.pop(event.context);
    });
  }

  @override
  Future<void> close() {
    _movieSubscription?.cancel();
    // TODO: implement close
    return super.close();
  }
}
