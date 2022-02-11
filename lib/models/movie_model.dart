class Movie {
  String? movieName;
  String? directorName;
  String? posterImgRef;
  String? docId;

  Movie({this.movieName, this.directorName, this.posterImgRef, this.docId});

  Map<String, dynamic> toMap() {
    return {
      'movieName': movieName,
      'directorName': directorName,
      'posterImgRef': posterImgRef,
      'docId': docId
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      movieName: map['movieName'] as String,
      directorName: map['directorName'] as String,
      posterImgRef: map['posterImgRef'] as String,
      docId: map['docId'] as String,
    );
  }

  @override
  String toString() {
    return 'Movie{movieName: $movieName, directorName: $directorName, posterImgRef: $posterImgRef, docId: $docId}';
  }
}
