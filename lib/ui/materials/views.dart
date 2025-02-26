import 'package:flutter/material.dart';
import 'package:message_app/data/database/sb_database.dart';
import 'package:message_app/ui/views/log_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Views extends StatelessWidget {
  final Function(BuildContext context) logOut;
  const Views({super.key, required this.logOut});


  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (String value){
        if(value == "logout"){
          logOut(context);
          print(value);
        }
        if(value == "profile"){
          print(value);
        }
      },
      itemBuilder: (BuildContext context){
          return <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(value: "profile", child: Text("Profile"),),
            const PopupMenuItem<String>(value: "logout",  child: Text("Log out"),),
          ];
      },);
  }
}



