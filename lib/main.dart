import 'package:flutter/material.dart';
import 'package:message_app/ui/views/add_person.dart';
import 'package:message_app/ui/views/log_in.dart';
import 'package:message_app/ui/views/main_page.dart';
import 'package:message_app/ui/views/search_result.dart';
import 'package:message_app/ui/views/sign_up.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LogIn(),
    );
  }
}
