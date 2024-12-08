part of 'auth_bloc.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

 class AuthState extends Equatable {
  const AuthState({
    this.activeTime,
    this.status = AuthStatus.unknown,
 });

  final DateTime? activeTime;

  final AuthStatus status;

  @override
  List<Object?> get props => [activeTime, status];

  // Method -> CopyWith
  AuthState copyWith({
    DateTime? activeTime,
    AuthStatus? status,
  }) => AuthState(
    activeTime: activeTime ?? this.activeTime,
    status: status ?? this.status,
  );
}
