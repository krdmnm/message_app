import 'package:flutter/material.dart';
import 'package:message_app/data/database/sb_database.dart';
import 'package:message_app/data/entity/app_user.dart';
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
      return await db.searchPersons(keyWord);
    } else {
      var persons = <Person>[];
      var person = Person(person_id: "1", person_name: "Ahmet", person_email: "5555555555");
      persons.add(person);
      return persons;
    }
  }


  //main_page.dart
  Future<List<Person>> getPersons() async {
    var persons = <Person>[];
    var p1 = Person(person_id: "1", person_name: "Ahmet", person_email: "5555555555");
    var p2 = Person(person_id: "2", person_name: "Mehmet", person_email: "5555555556");
    var p3 = Person(person_id: "3", person_name: "Ali", person_email: "5555555557");
    var p4 = Person(person_id: "4", person_name: "Veli", person_email: "5555555558");
    var p5 = Person(person_id: "5", person_name: "Can", person_email: "5555555559");
    persons.add(p1);
    persons.add(p2);
    persons.add(p3);
    persons.add(p4);
    persons.add(p5);
    return persons;
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