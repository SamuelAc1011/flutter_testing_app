import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_testing_app/auth/repository/activity_repository.dart';
import 'package:logger/logger.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class ActivityMonitorBloc
    extends Bloc<ActivityMonitorEvent, ActivityMonitorState> {
  ActivityMonitorBloc(this._userActivityMonitor)
      : super(const ActivityMonitorState.unknown()) {

    // Action -> The repository is listening to the user's activity status
    _userActivityMonitor.status.listen((activityStatus) {
      if (activityStatus == ActivityStatus.inactive) {
        add(LogOut());
      }
    });

    on<ExtendAuthSession>(_extendAuthSession);
    on<LogOut>(_onLogOut);
  }

  // Attribute -> _logger
  /// Logger for the ActivityMonitorBloc.
  final Logger _logger = Logger();

  // Attribute -> _userActivityMonitor
  /// Repository that manages the user's activity status.
  final UserActivityMonitor _userActivityMonitor;

  // Method -> _extendAuthSession
  /// Extends the user's session by the given duration.
  Future<void> _extendAuthSession(
    ExtendAuthSession event,
    Emitter<ActivityMonitorState> emit,
  ) async {
    _logger.i(
      'Extendiendo sesión del usuario por ${event.duration.inSeconds} segundos',
    );
    _userActivityMonitor.userDidAction(event.duration);
    emit(const ActivityMonitorState.active());
  }

  // Method -> _onLogOut
  /// Logs the user out of the application by setting the user's status to
  /// inactive.
  void _onLogOut(LogOut event, Emitter<ActivityMonitorState> emit) {
    emit(const ActivityMonitorState.inactive());
  }
}
