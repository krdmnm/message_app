import 'package:flutter/material.dart';
import 'package:message_app/data/database/sb_database.dart';
import 'package:message_app/data/entity/app_user.dart';
import 'package:message_app/data/entity/messages.dart';
import 'package:message_app/ui/views/main_page.dart';
import 'package:message_app/ui/views/message.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../ui/views/log_in.dart';
import '../entity/person.dart';

class Dao {


  //login.dart - log in button
  Future<void> logIn(String email, String password, BuildContext context) async {
    if(email.isNotEmpty && password.isNotEmpty){
      final db = Database();
      AppUser user = await db.logIn(email, password);
      final sp = await SharedPreferences.getInstance();
      await sp.setString("email", user.user_email);
      await sp.setString("password", password);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainPage(user: user,)));
      //messages sayfasına yönlendir
    } else {
      print("TextField is empty - Login unseccessfull");
      //showAlertDialog(, "Warning", "Please fill all fields");
    }
  }

  //main_page.cubit - logOut()
  Future<void> logOut(BuildContext context) async {
    final db = Database();
    await db.logOut();
    final sp = await SharedPreferences.getInstance();
    sp.remove("email");
    sp.remove("password");
    sp.clear();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LogIn()));
  }

  //sign_up.dart
  Future<void> signUp(BuildContext context, String email, String name, String password) async {
    if(email.isNotEmpty && name.isNotEmpty && password.isNotEmpty){
      final db = Database();
      var user = await db.signUp(email, password, name);
      if(user != null){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Sign up successful"), duration: Duration(seconds: 1)));
        Navigator.push(context, MaterialPageRoute(builder: (context)=>LogIn()));
      } else {
        showAlertDialog(context, "Warning", "Could not sign up try again later");
      }
    }else{
      showAlertDialog(context, "Warning", "Fill all fields");
    }
  }

  //main_page.dart - kayıtlı kişilerden aramak için
  Future<List<Person>> searchPersons(String keyWord) async {
    if(keyWord.isNotEmpty){
      final db = Database();
      var response = await db.searchPersons(keyWord);
      print("dao searchPersons : $response");
      var persons = <Person>[];
      for(var person in response){
        var p = Person(person_id: person['person_id'], person_name: person['person_name'], person_email: person['person_email']);
        persons.add(p);
      }
      return persons;
    } else {
      return <Person>[];
    }
  }

  //add_person_cubit searchUser
  Future<void> searchUser(String keyWord) async {
    final db = Database();
    db.searchUser(keyWord);
  }

  //add_person_cubit addUser
  Future<void> addUser(String userId) async {

  }


  //main_page.dart
  Future<List<Person>> getPersons() async {
    final db = Database();
    return await db.getPersons();
  }

  Future<void> deletePerson(String id) async {
    final db = Database();
    db.deletePerson(id);
  }

  Future<List<Messages>> getMessages(String personId) async {
    final db = Database();
    final messages =  await db.getMessages(personId);
    return messages;
  }

  void handleInserts(payload)  {
    print("handleInserts $payload");
  }

  Future<void> sendMessage(String messageContent, String personId) async {
    final db = Database();
    db.sendMessage(messageContent, personId);
  }

}

void showAlertDialog(BuildContext context, String title, String content){
  showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [TextButton(onPressed: (){
            Navigator.of(context).pop();
          }, child: Text("OK"),)],);
      });
}