import 'package:flutter/material.dart';
import 'package:movies/models/movie_model.dart';
import 'package:movies/service/api/movie_api.dart';

class MovieTile extends StatelessWidget {
  const MovieTile({Key? key, required this.movie}) : super(key: key);
  final Movie movie;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width / 30, vertical: 0),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Container(
              width: width,
              height: height / 4,
              color: const Color(0xE31A1A44),
              alignment: Alignment.bottomRight,
              child: SizedBox(
                width: width / 2.2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 18.0),
                        child: TextButton(
                          child: Text(
                            'delete',
                            style: TextStyle(
                                fontSize: 20, color: Color(0xFFF16217)),
                          ),
                          onPressed: () async {
                            await MovieApi()
                                .deleteMovie(movie.docId!, movie.posterImgRef!);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      movie.movieName!,
                      style: const TextStyle(
                          color: Color(0xE3C1C4F7),
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Director : ' + movie.directorName!,
                      style: const TextStyle(
                        color: Color(0xE3C1C4F7),
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(18.0),
                  child: Material(
                    elevation: 10,
                    child: Image.network(
                      movie.posterImgRef!,
                      fit: BoxFit.cover,
                      height: height / 3.5,
                      width: width / 2.75,
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
