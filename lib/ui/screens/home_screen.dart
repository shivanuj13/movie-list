import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/bloc/auth/auth_bloc.dart';
import 'package:movies/bloc/movie/movie_bloc.dart';
import 'package:movies/constants/routes_constant.dart';
import 'package:movies/models/movie_model.dart';
import 'package:movies/service/api/auth_api.dart';
import 'package:movies/ui/widgets/movie_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xE3010225),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xE34E4E9F),
        child: const Icon(Icons.add),
        onPressed: () {
          if (FirebaseAuth.instance.currentUser != null) {
            BlocProvider.of<AuthBloc>(context).add(InitializeAuth());
            Navigator.pushNamed(context, addMoviePageRoute);
          } else {
            Navigator.pushNamed(context, authPageRoute);
          }
        },
      ),
      appBar: AppBar(
        title: const Text(
          'Movies List',
          style: TextStyle(color: Color(0xE3C1C4F7), fontSize: 25),
        ),
        backgroundColor: const Color(0xE31A1A44),
        actions: [
          TextButton(
            onPressed: () async {
              AuthApi authApi = AuthApi();
              await authApi.signOut();
            },
            child: const Text(
              'Sign Out',
              style: TextStyle(fontSize: 20, color: Color(0xFFF16217)),
            ),
          ),
        ],
      ),
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
          } else if (state is MovieLoaded) {
            return ListView(
              padding: const EdgeInsets.all(0),
              children: [
                for (Movie item in state.movieList!) MovieTile(movie: item),
              ],
            );
          } else if (state is MovieEmpty) {
            return const Center(
                child: Text(
              'List is Empty for now, Try to add some!',
              style: TextStyle(color: Color(0xE3C1C4F7), fontSize: 20),
            ));
          } else {
            return const Center(
              child: Text(
                'something went wrong',
                style: TextStyle(color: Color(0xE3C1C4F7), fontSize: 20),
              ),
            );
          }
        },
      ),
    );
  }
}
