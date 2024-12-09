part of 'auth_bloc.dart';

sealed class ActivityMonitorEvent extends Equatable {
  const ActivityMonitorEvent();

  @override
  List<Object> get props => [];
}

class ExtendAuthSession extends ActivityMonitorEvent {
  const ExtendAuthSession(this.duration);

  final Duration duration;

  @override
  List<Object> get props => [duration];
}

class LogOut extends ActivityMonitorEvent {}
