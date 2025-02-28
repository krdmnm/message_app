import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_app/data/repository/dao.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:postgrest/postgrest.dart';

import '../../data/entity/messages.dart';

class MessageCubit extends Cubit<List<Messages>>{
  MessageCubit():super(<Messages>[]){liveMessage();}
  late final StreamSubscription<List<Map<String, dynamic>>> messagesSubscription;

  var dao = Dao();

  Future<void> liveMessage() async {
    final supabase = Supabase.instance.client;
    supabase.channel('messages')
        .onPostgresChanges(event: PostgresChangeEvent.insert, schema: 'public', table: 'messages', callback: handleInserts).subscribe();
  }

  Future<void> trackOnlineStatus(String personId) async {
    final supabase = Supabase.instance.client;
    final presence = supabase.channel('presence');
    presence.onPresenceSync((payload) {
      final onlineUsers = presence.presenceState();
      onlineUsers.forEach((presenceState) {
        presenceState.presences.forEach((presence) {
          final userId = presence.payload['user_id'];
          final status = presence.payload['status'];
          print('Kullanıcı ID: $userId, Durum: $status');
        });
      });
    }).subscribe();

  }

  void handleInserts(PostgresChangePayload payload) async {
    final parsedDate = DateTime.parse(payload.newRecord['created_at']);
    final newMessage = Messages(id: payload.newRecord['id'],
        sender_id: payload.newRecord['sender_id'],
        reciever_id: payload.newRecord['reciever_id'],
        content: payload.newRecord['content'],
        date: parsedDate,
        status: payload.newRecord['status']);
    var messages = state;
    emit([...messages, newMessage]);
  }

  Future<void> getMessages(String personId) async {
    var messages = await dao.getMessages(personId);
    emit(messages);
  }

  Future<void> sendMessage(String messageContent, String personId) async {
    dao.sendMessage(messageContent, personId);
  }



}

