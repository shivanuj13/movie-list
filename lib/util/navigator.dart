import 'package:flutter/material.dart';
import 'package:movies/constants/routes_constant.dart';
import 'package:movies/ui/screens/add_movie_screen.dart';
import 'package:movies/ui/screens/google_auth_screen.dart';
import 'package:movies/ui/screens/home_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case homePageRoute:
      return MaterialPageRoute(builder: (context) => const HomeScreen());
    case addMoviePageRoute:
      return MaterialPageRoute(builder: (context) => const AddMovie());
    case authPageRoute:
      return MaterialPageRoute(builder: (context) => const GoogleAuthPage());
    default:
      return MaterialPageRoute(builder: (context) => const HomeScreen());
  }
}
