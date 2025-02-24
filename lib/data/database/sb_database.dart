import 'package:message_app/data/entity/app_user.dart';
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
      final sp = await SharedPreferences.getInstance();
      await sp.setString("email", response.user!.email!);
      await sp.setString("password", password);
      print("User logged in ${user.user_name} - ${user.user_email} - ${user.user_id}");
      return user;
    } else {
      return AppUser(user_id: "", user_name: "", user_email: "");
    }

  }



}