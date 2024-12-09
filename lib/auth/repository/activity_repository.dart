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

  // Method -> status
  /// Stream that tracks the user's activity status.
  Stream<ActivityStatus> get status => _controller.stream;

  void userDidAction(Duration inactivityDuration) {
    _resetInactivityTimer(inactivityDuration);
  }

  void _resetInactivityTimer(Duration inactivityDuration) {
    _inactivityTimer?.cancel();
    _controller.add(ActivityStatus.active);
    _inactivityTimer = Timer(inactivityDuration, _setUserInactive);
  }

  void _setUserInactive() {
    _logger.e('The user was inactive for too long.');
    _inactivityTimer?.cancel();
    _controller.add(ActivityStatus.inactive);
  }

  void dispose() {
    _inactivityTimer?.cancel();
    _controller.close();
  }
}
