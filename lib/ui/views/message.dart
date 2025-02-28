import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_app/data/entity/app_user.dart';
import 'package:message_app/data/entity/messages.dart';
import 'package:message_app/ui/cubits/message_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../data/database/sb_database.dart';
import '../../data/entity/person.dart';
import '../materials/colors.dart';

class Message extends StatefulWidget {
  //const Message({super.key});
  Person person;
  Message({required this.person});


  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  AppUser? currentUser = null;
  String status = "offline";
  var tfMessage = TextEditingController();

  @override
  void initState()  {
    super.initState();
    context.read<MessageCubit>().trackOnlineStatus(widget.person.person_id);
    final supabase =  Supabase.instance.client;
    final _currentUser =  supabase.auth.currentUser;
    currentUser = AppUser(user_id: _currentUser!.id, user_name: _currentUser.userMetadata!['display_name'], user_email: _currentUser.email!);
    print("Message.dart initState(CurrentUSer) : ${currentUser!.user_id}");
    print("Message.dart initState(Person) : ${widget.person.person_id}");
    context.read<MessageCubit>().getMessages(widget.person.person_id);
  }

  Future<void> trackOnlineStatus() async {
    final supabase = Supabase.instance.client;
    final presence = supabase.channel('presence');
    presence.onPresenceSync((payload){
      var onlineUsers = presence.presenceState();
      onlineUsers.forEach((onlineUser){
        if(onlineUser.key == currentUser!.user_id){
          setState(() {
            status = 'online';
          });
        }
      });
    }).subscribe();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${widget.person.person_name} - $status"),),
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(color: white,
              child: BlocBuilder<MessageCubit, List<Messages>>(
                  builder: (context, messageList){
                    if(messageList.isNotEmpty){
                      return ListView.builder(
                        itemCount: messageList.length,
                        itemBuilder: (context, index){
                          var message = messageList[index];
                          return SizedBox(width:400,
                            child: Card(color: message.sender_id==widget.person.person_id ?  lightPrimaryColor : darkPrimaryColor,//Person message elementi
                              child: Row(
                                children: [
                                  Flexible(child: Text("${message.content}"),),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }else {
                      return const Center();
                    }
                  }),
            ),
          ),

          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey[300]!)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Your message',
                    ),
                    controller: tfMessage, // TextField'a controller ekleyin
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    // Mesaj gönderme işlemini burada gerçekleştirin
                    final messageContent = tfMessage.text.trim();
                    if (messageContent.isNotEmpty) {
                      // Mesaj gönderme fonksiyonunuzu çağırın
                      context.read<MessageCubit>().sendMessage(messageContent, widget.person.person_id);
                      tfMessage.clear(); // Gönderdikten sonra textfieldi temizle
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );

  }
}
