part of 'call_bloc.dart';

@immutable
sealed class CallState {}

final class CallInitial extends CallState {}

 class CallIDSet extends CallState {
  final String callID;
  CallIDSet(this.callID);
}
class CallLoading extends CallState {}

class CallStarted extends CallState {
  final int appID;
  final String appSign;
  final String userID;
  final String userName;
  final String callID;

  CallStarted({
    required this.appID,
    required this.appSign,
    required this.userID,
    required this.userName,
    required this.callID,
  });
}

 class CallError extends CallState {
  final String message;
  CallError(this.message);
}

 class CallEnded extends CallState {}