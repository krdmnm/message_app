import 'package:message_app/data/entity/app_user.dart';
import 'package:message_app/data/entity/messages.dart';
import 'package:message_app/data/entity/person.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Database {

  bool isInitialized = false;
  String url = 'https://soqxzbygwrisbxexlxwx.supabase.co';
  String anonkey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNvcXh6Ynlnd3Jpc2J4ZXhseHd4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDAzMTMwNDAsImV4cCI6MjA1NTg4OTA0MH0.gvocNtrmvZLgaOInnBZURiHhP0npNQsXfkBFGSwcqN8';

  Future<void> initialize() async {
    if(!isInitialized){
      await Supabase.initialize(url: url, anonKey: anonkey);
      isInitialized = true;
      print("Supabase initialized");
    }
  }

  Future<SupabaseClient> getInstance() async {
    return Supabase.instance.client;
  }

  //dao.dart - logIn()
  Future<AppUser> logIn(String email, String password) async {
    final supabase = await getInstance();
    final response = await supabase.auth.signInWithPassword(email: email, password: password);
    if(response.user != null){
      final user = AppUser(user_id: response.user!.id,
          user_name: response.user!.userMetadata!['display_name'],
          user_email: response.user!.email!);
      print("User logged in ${user.user_name} - ${user.user_email} - ${user.user_id}");
      return user;
    } else {
      return AppUser(user_id: "", user_name: "", user_email: "");
    }

  }

  //views.dart
  Future<void> logOut() async {
    final supabase = await getInstance();
    await supabase.auth.signOut();
    print("User logged out");
  }

  //dao.dart - signUp()
  Future<User?> signUp(String email, String password, String name) async {
    final supabase = await getInstance();
    final response = await supabase.auth.signUp(email: email,
        password: password,
    data: {'display_name' : name});
    //create table
    final userId = response.user!.id;
    try{
      final tableName = "$userId";
      await supabase.rpc('create_table_if_not_exists', params: {'table_name': tableName});
      print("Table Created");
    } catch (e){
      print("Error creating table - $e");
    }
    return response.user;
  }

  //dao.dart - searchPersons()
  Future<List<Map<String, dynamic>>> searchPersons(String keyword) async {
    final supabase = await getInstance();
    final currentUser = await supabase.auth.currentUser;
    final response = await supabase.from(currentUser!.id).select().ilike("person_name", keyword);
    return response;
  }

  Future<List<Person>> getPersons() async {
    final supabase = await getInstance();
    final currentUser = await supabase.auth.currentUser;
    final response = await supabase.from(currentUser!.id).select();
    print("database getPersons : $response");
    if(response.isNotEmpty){
      return List.generate(response.length, (index){
        var person = response[index];
        return Person(person_id: person['person_id'], person_name: person['person_name'], person_email: person['person_email']);
      });
    } else {
      return <Person>[];
    }
  }

  Future<void> deletePerson(String id) async {
    final supabase = await getInstance();
    final currentUser = await supabase.auth.currentUser;
    await supabase.from(currentUser!.id).delete().eq('person_id', id);
  }


  //dao.dart - searchUser()
  Future<void> searchUser(String keyWord) async {

  }

  //dao.dart - getMessages()
  Future<List<Messages>> getMessages(String personId) async {
    final supabase = await getInstance();
    final currentUser = await supabase.auth.currentUser;
    final response = await supabase.from('messages').select()
        .or('reciever_id.eq.$personId,sender_id.eq.${currentUser!.id}').or('reciever_id.eq.${currentUser.id},sender_id.eq.$personId');
    print("database getMessages : $response");
    return List.generate(response.length, (index){
      var message = response[index];
      return Messages(id: message['id'], sender_id: message['sender_id'], reciever_id: message['reciever_id'],
          content: message['content'], date: message['created_at'], time: message['created_at'],
          status: message['status']);
    });
  }



}