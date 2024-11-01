part of 'call_bloc.dart';

@immutable
sealed class CallEvent {}

class SetCallID extends CallEvent {
  final String callID;
  SetCallID(this.callID);
}

class StartCall extends CallEvent {
  final int appID; 
  final String appSign;
  final String userID;
  final String userName;
  final String callID;

  StartCall({
    required this.appID,
    required this.appSign,
    required this.userID,
    required this.userName,
    required this.callID,
  });
}

class EndCall extends CallEvent {}

class CallFailed extends CallEvent {
  final String errorMessage;
  CallFailed(this.errorMessage);
}