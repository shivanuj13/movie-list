import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movies/bloc/movie/movie_bloc.dart';

class AddMovie extends StatefulWidget {
  const AddMovie({Key? key}) : super(key: key);

  @override
  _AddMovieState createState() => _AddMovieState();
}

class _AddMovieState extends State<AddMovie> {
  File? _file;
  TextEditingController movieNameController = TextEditingController();
  TextEditingController directorNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xE31A1A44),
        title: const Text('Add A Movie'),
      ),
      backgroundColor: const Color(0xE3010225),
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieLoading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Please Wait for a while!!',
                    style: TextStyle(color: Color(0xE3C1C4F7), fontSize: 20),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CircularProgressIndicator(),
                ],
              ),
            );
          } else {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 20),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: height / 3.5,
                      width: width,
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: const Color(0xE3C1C4F7),
                      )),
                      child: _file == null
                          ? IconButton(
                              iconSize: 40,
                              onPressed: () async {
                                XFile? xfile = await ImagePicker().pickImage(
                                    source: ImageSource.gallery,
                                    imageQuality: 50);
                                if (xfile != null) {
                                  setState(() {
                                    _file = File(xfile.path);
                                  });
                                }
                              },
                              color: const Color(0xE3C1C4F7),
                              icon: const Icon(Icons.add_a_photo),
                            )
                          : Image.file(
                              _file!,
                              fit: BoxFit.cover,
                            ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: movieNameController,
                      style: const TextStyle(
                          color: Color(0xE3C1C4F7), fontSize: 20),
                      decoration: const InputDecoration(
                          filled: true,
                          hintText: 'Movie Name',
                          hintStyle:
                              TextStyle(color: Color(0xE3C1C4F7), fontSize: 20),
                          fillColor: Color(0xE34E4E9F)),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: directorNameController,
                      style: const TextStyle(
                          color: Color(0xE3C1C4F7), fontSize: 20),
                      decoration: const InputDecoration(
                          filled: true,
                          hintText: 'Director Name',
                          hintStyle:
                              TextStyle(color: Color(0xE3C1C4F7), fontSize: 20),
                          fillColor: Color(0xE34E4E9F)),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xE34E4E9F),
        onPressed: () async {
          // MovieApi movieApi = MovieApi();
          // await movieApi.addMovie(
          //     movieNameController.text, directorNameController.text, _file!);
          final MovieBloc movieBloc = BlocProvider.of<MovieBloc>(context);
          movieBloc.add(AddMovieEvent(
              movieName: movieNameController.text,
              directorName: directorNameController.text,
              posterImg: _file!,
              context: context));
        },
        child: const Icon(Icons.done),
      ),
    );
  }
}
