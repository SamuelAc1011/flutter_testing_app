import 'dart:async';

import 'package:logger/logger.dart';

enum ActivityStatus { active, inactive, unknown }

class UserActivityMonitor {
  // Attribute -> _controller
  /// Stream controller that tracks the user's activity status.
  final _controller = StreamController<ActivityStatus>();

  // Attribute -> _inactivityTimer
  /// Timer that tracks the user's inactivity.
  Timer? _inactivityTimer;

  // Attribute -> _logger
  /// Logger for the UserActivityMonitor.
  final Logger _logger = Logger();

  // Stream<ActivityStatus> get status async* {
  //   yield ActivityStatus.unknown;
  //   yield* _controller.stream;
  // }

  Stream<ActivityStatus> get status => _controller.stream;

  void userDidAction(Duration inactivityDuration) {
    _logger.i(
      'Usuario realizó una acción, se agregó al temporizador de inactividad',
    );
    _resetInactivityTimer(inactivityDuration);
  }

  void _resetInactivityTimer(Duration inactivityDuration) {
    _inactivityTimer?.cancel();
    _controller.add(ActivityStatus.active);
    _inactivityTimer = Timer(inactivityDuration, _setUserInactive);
  }

  void _setUserInactive() {
    _logger.e('Usuario inactivo en: ${DateTime.now()}');
    _inactivityTimer?.cancel();
    _controller.add(ActivityStatus.inactive);
  }

  void dispose() {
    _inactivityTimer?.cancel();
    _controller.close();
  }
}
