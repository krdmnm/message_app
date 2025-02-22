import 'package:flutter/material.dart';
import '../../data/entity/person.dart';

class Message extends StatefulWidget {
  //const Message({super.key});
  Person person;
  Message({required this.person});

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${widget.person.person_name} - ${widget.person.person_phone}"),),
      body: const Center(),
    );
  }
}
