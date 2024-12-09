part of 'auth_bloc.dart';

class ActivityMonitorState extends Equatable {
  const ActivityMonitorState._({
    this.status = ActivityStatus.unknown,
  });

  const ActivityMonitorState.unknown() : this._();

  const ActivityMonitorState.active()
      : this._(
          status: ActivityStatus.active,
        );

  const ActivityMonitorState.inactive()
      : this._(
          status: ActivityStatus.inactive,
        );

  final ActivityStatus status;

  @override
  List<Object?> get props => [status];
}
