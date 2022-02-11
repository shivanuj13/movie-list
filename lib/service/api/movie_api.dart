import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:movies/models/movie_model.dart';
import 'package:movies/service/repository/movie_repo.dart';

class MovieApi implements MovieRepo {
  //to make it a singleton class
  MovieApi._();
  static final MovieApi _movieApi = MovieApi._();
  factory MovieApi() => _movieApi;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  @override
  Future<void> addMovie(
      String movieName, String directorName, File posterImg) async {
    try {
      String url = await _firebaseStorage
          .ref(DateTime.now().toString())
          .putFile(posterImg)
          .then((taskSnapshot) {
        return taskSnapshot.ref.getDownloadURL();
      });
      Movie movie = Movie(
          movieName: movieName,
          directorName: directorName,
          posterImgRef: url,
          docId: 'test');
      DocumentReference documentReference =
          await _firestore.collection('movies').add(movie.toMap());
      await documentReference.update({'docId': documentReference.id});
    } on FirebaseException catch (e) {
      print(e.message);
    } on SocketException catch (e) {
      print(e.toString());
    }
  }

  @override
  Stream<List<Movie>?> fetchMovie() {
    {
      try {
        return _firestore
            .collection('movies')
            .orderBy('movieName')
            .snapshots()
            .map((event) {
          return event.docs.map((e) {
            return Movie.fromMap(e.data());
          }).toList();
        });
      } on FirebaseException catch (e) {
        print(e.message);
        rethrow;
      }
    }
  }

  @override
  Future<void> deleteMovie(String docId, String imgUrl) async {
    try {
      await _firestore.collection('movies').doc(docId).delete();
      await _firebaseStorage.refFromURL(imgUrl).delete();
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }
}
