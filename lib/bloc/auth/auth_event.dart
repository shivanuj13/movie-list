part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class InitializeAuth extends AuthEvent {
  @override
  List<Object> get props => [];
}

class AuthUserEvent extends AuthEvent {
  final BuildContext context;

  @override
  List<Object> get props => [BuildContext];

  const AuthUserEvent({
    required this.context,
  });
}
