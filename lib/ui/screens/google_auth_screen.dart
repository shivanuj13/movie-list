import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/bloc/auth/auth_bloc.dart';

class GoogleAuthPage extends StatefulWidget {
  const GoogleAuthPage({Key? key}) : super(key: key);

  @override
  _GoogleAuthPageState createState() => _GoogleAuthPageState();
}

class _GoogleAuthPageState extends State<GoogleAuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xE3010225),
      body: Center(
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthInitial) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'YOU NEED TO SIGN IN FIRST !!',
                    style: TextStyle(color: Color(0xE3C1C4F7), fontSize: 20),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        fixedSize:
                            MaterialStateProperty.all(const Size(250, 50)),
                        backgroundColor: MaterialStateProperty.all(
                          const Color(0xE34E4E9F),
                        )),
                    onPressed: () async {
                      BlocProvider.of<AuthBloc>(context)
                          .add(AuthUserEvent(context: context));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Continue With Google'),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(
                              'https://www.transparentpng.com/thumb/google-logo/google-logo-png-icon-free-download-SUF63j.png'),
                        )
                      ],
                    ),
                  ),
                ],
              );
            } else if (state is AuthProgress) {
              return Column(
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
              );
            } else {
              return Text(
                state.toString(),
                style: const TextStyle(color: Color(0xE3C1C4F7), fontSize: 20),
              );
            }
          },
        ),
      ),
    );
  }
}
