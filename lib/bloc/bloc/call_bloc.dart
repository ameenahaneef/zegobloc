import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:zegobloc/constants/callinfo.dart';

part 'call_event.dart';
part 'call_state.dart';

class CallBloc extends Bloc<CallEvent, CallState> {
  CallBloc() : super(CallInitial()) {
    on<SetCallID>((event, emit) {
      emit(CallIDSet(event.callID));
    });

    on<StartCall>((event,emit)async{
      emit(CallLoading());
      try {
        await Future.delayed(const Duration(seconds: 2)); 
        emit(CallStarted(
          appID: Callinfo.appId, 
          appSign: Callinfo.appSign, 
          userID: Random().nextInt(9999).toString(), 
          userName: 'user_name_${Random().nextInt(9999)}', 
          callID: event.callID,
        ));
      } catch (e) {
        emit(CallError(e.toString()));
        
      }
    });
    on<EndCall>((event, emit) {
      emit(CallEnded());
    });

    on<CallFailed>((event, emit) {
      emit(CallError(event.errorMessage));
    });
  }
}
