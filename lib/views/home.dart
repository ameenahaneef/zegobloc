import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zegobloc/bloc/bloc/call_bloc.dart';
import 'package:zegobloc/constants/callinfo.dart';
import 'package:zegobloc/constants/styles.dart';
import 'package:zegobloc/views/call_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final callIDController = TextEditingController();
  final userID = Random().nextInt(9999).toString(); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<CallBloc, CallState>(
        listener: (context, state) {
          if (state is CallLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is CallError) {
            Navigator.of(context).pop(); 
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is CallEnded) {
            Navigator.of(context).pop(); 
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Call ended')),
            );
          } else {
            Navigator.of(context).pop(); 
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: callIDController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Call ID',
                    hintText: 'Enter Call ID',
                  ),
                ),
                height15,
                ElevatedButton(
                  onPressed: () {
                    final callID = callIDController.text.trim();
                    if (callID.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please enter a Call ID')),
                      );
                    } else {
                      context.read<CallBloc>().add(SetCallID(callID));
                      context.read<CallBloc>().add(StartCall(
                        appID: Callinfo.appId,
                        appSign: Callinfo.appSign,
                        userID: userID,
                        userName: 'user_name',
                        callID: callID,
                      ));
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CallPage(callID: callID),
                        ),
                      );
                    }
                  },
                  child: const Text('Join'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
