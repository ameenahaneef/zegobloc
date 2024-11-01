import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zegobloc/bloc/bloc/call_bloc.dart';
import 'package:zegobloc/constants/callinfo.dart';

final userId = Random().nextInt(9999);
class CallPage extends StatelessWidget {
  const CallPage({Key? key, required this.callID}) : super(key: key);
  final String callID;

  @override
  Widget build(BuildContext context) {
    context.read<CallBloc>().add(StartCall(
          appID: Callinfo.appId,
          appSign: Callinfo.appSign,
          userID: userId.toString(),
          userName: 'user_name',
          callID: callID,
        ));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Call Page'),
      ),
      body: ZegoUIKitPrebuiltCall(
        appID: Callinfo.appId,
        appSign: Callinfo.appSign,
        userID: userId.toString(),
        userName: 'user_name',
        callID: callID,
        config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
      ),
    );
  }
}
