import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:movies/constants/routes_constant.dart';
import 'package:movies/service/api/auth_api.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthApi _authApi = AuthApi();
  AuthBloc() : super(AuthInitial()) {
    on<AuthUserEvent>((event, emit) async {
      emit(AuthProgress());
      await _authApi.signInWithGoogle();
      emit(AuthComplete());
      Navigator.pushReplacementNamed(event.context, addMoviePageRoute);
    });
    on<InitializeAuth>((event, emit) => emit(AuthInitial()));
  }
}
