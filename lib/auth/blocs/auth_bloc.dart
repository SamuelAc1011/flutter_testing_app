import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_testing_app/auth/repository/activity_repository.dart';
import 'package:logger/logger.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Logger _logger = Logger();
  final UserActivityMonitor _userActivityMonitor;

  AuthBloc(this._userActivityMonitor) : super(const AuthState()) {
    // Escucha los cambios de actividad
    _userActivityMonitor.status.listen((activityStatus) {
      if (activityStatus == ActivityStatus.inactive) {
        add(LogOut()); // Cerrar sesión si el usuario está inactivo
      }
    });

    on<ExtendAuthSession>(_extendAuthSession);
    on<LogOut>(_onLogOut);
  }

  Future<void> _extendAuthSession(
    ExtendAuthSession event,
    Emitter<AuthState> emit,
  ) async {
    _logger.i(
      'Extendiendo sesión del usuario por ${event.duration.inSeconds} segundos',
    );
    _userActivityMonitor.userDidAction(event.duration);
    // Aquí es donde extendemos la sesión al detectar actividad
    emit(
      state.copyWith(
        status: AuthStatus.authenticated,
        activeTime: DateTime.now(),
      ),
    );
  }

  void _onLogOut(LogOut event, Emitter<AuthState> emit) {
    emit(
      state.copyWith(
        status: AuthStatus.unauthenticated,
        activeTime: DateTime.now(),
      ),
    );
  }
}

// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   AuthBloc(
//     this._userActivityMonitor,
//   ) : super(const AuthState()) {
//     on<ExtendAuthSession>(_extendAuthSession);
//     on<LogOut>(_onLogOut);
//
//     _userActivityMonitor.status.listen((status) {
//       if (status == ActivityStatus.inactive) {
//         add(LogOut());
//       }
//     });
//   }
//
//   // Attribute -> _logger
//   /// Logger for the AuthBloc.
//   final Logger _logger = Logger();
//
//   // Attribute -> _userActivityMonitor
//   /// Monitors the user's activity.
//   final UserActivityMonitor _userActivityMonitor;
//
//   // Method -> _extendAuthSession
//   /// Extends the user's session. This is used to keep the user logged in.
//   Future<void> _extendAuthSession(
//       ExtendAuthSession event, Emitter<AuthState> emit) async {
//     _userActivityMonitor.userDidAction();
//     return emit.onEach(
//       _userActivityMonitor.status,
//       onData: (data) async {
//         switch (data) {
//           case ActivityStatus.unknown:
//             break;
//           case ActivityStatus.active:
//             emit(
//               state.copyWith(
//                 activeTime: DateTime.now(),
//                 status: AuthStatus.authenticated,
//               ),
//             );
//           case ActivityStatus.inactive:
//             emit(
//               state.copyWith(
//                 activeTime: DateTime.now(),
//                 status: AuthStatus.unauthenticated,
//               ),
//             );
//         }
//       },
//     );
//   }
//
//   // Method -> _onLogOut
//   /// Logs out the user.
//   void _onLogOut(LogOut event, Emitter<AuthState> emit) {
//     // _userActivityMonitor.dispose();
//     emit(
//       state.copyWith(
//         activeTime: DateTime.now(),
//         status: AuthStatus.unauthenticated,
//       ),
//     );
//   }
//
// }
