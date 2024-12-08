part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class ExtendAuthSession extends AuthEvent {
  const ExtendAuthSession(this.duration);

  final Duration duration;

  @override
  List<Object> get props => [duration];
}

class LogOut extends AuthEvent {}
