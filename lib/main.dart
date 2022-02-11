import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/bloc/movie/movie_bloc.dart';
import 'package:movies/constants/routes_constant.dart';
import 'package:movies/util/navigator.dart';

import 'bloc/auth/auth_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MovieBloc(),
        ),
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
      ],
      child: const MaterialApp(
        onGenerateRoute: generateRoute,
        initialRoute: homePageRoute,
      ),
    );
  }
}
