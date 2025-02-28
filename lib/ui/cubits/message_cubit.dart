import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_app/data/repository/dao.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/entity/messages.dart';

class MessageCubit extends Cubit<List<Messages>>{
  MessageCubit():super(<Messages>[]);
  late final StreamSubscription<List<Map<String, dynamic>>> messagesSubscription;

  var dao = Dao();

  Future<void> getMessages(String personId) async {
    final supabase = Supabase.instance.client;
    final currentUser = await supabase.auth.currentUser;
    messagesSubscription = supabase
        .from('messages')
        .stream(primaryKey: ['id'])
        .eq('sender_id', personId)
        .order('created_at', ascending: true)
        .listen((messages) {
          print("MessageCubit.dart getMessages() : $messages");
      emit(messages.map((message) => Messages(
        id: message['id'],
        sender_id: message['sender_id'],
        reciever_id: message['reciever_id'],
        content: message['content'],
        date: DateTime.parse(message['created_at']),
        time: DateTime.parse(message['created_at']),
        status: message['status'],
      )).toList());

    });

    //final messages = await dao.getMessages(personId);
    //emit(messages);
  }

  Future<void> sendMessage(String messageContent) async {

  }

}

/*


 */