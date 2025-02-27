import 'package:flutter/material.dart';
import 'package:message_app/data/entity/app_user.dart';
import 'package:message_app/ui/cubits/add_person_cubit.dart';
import 'package:message_app/ui/materials/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:message_app/data/entity/app_user.dart';
import 'package:message_app/ui/cubits/main_page_cubit.dart';
import 'package:message_app/ui/materials/colors.dart';
import 'package:message_app/ui/materials/views.dart';
import 'package:message_app/ui/views/add_person.dart';
import 'package:message_app/ui/views/message.dart';
import '../../data/entity/person.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../materials/views.dart';

class AddPerson extends StatefulWidget {
  const AddPerson({super.key});

  @override
  State<AddPerson> createState() => _AddPersonState();
}

class _AddPersonState extends State<AddPerson> {
  var tfPersonPhone = TextEditingController();
  var tfPersonName = TextEditingController();
  bool isSearchActive = false;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: darkPrimaryColor,
        title: isSearchActive ? TextField(style: TextStyle(color: primaryText) ,decoration: const InputDecoration(hintText: "Search",),
          onChanged: (keyWord){
            context.read<AddPersonCubit>().searchUser(keyWord);
          },)
            : Text("Add your friends", style: TextStyle(color: primaryText),),

        actions: [isSearchActive ?
        IconButton(onPressed: (){
          setState(() {
            isSearchActive = false;
          });
        }, icon: Icon(Icons.clear))

            :

        IconButton(onPressed: (){
          setState(() {
            isSearchActive = true;
          });
        }, icon: Icon(Icons.search)),
          Views(logOut: (context) {
            context.read<AddPersonCubit>().logOut(context);
            //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LogIn()));
          },),
        ],),

      body: Container(color: white,
        child: BlocBuilder<AddPersonCubit, List<AppUser>>(
            builder: (context, userList){
              if(userList.isNotEmpty){
                return ListView.builder(
                  itemCount: userList.length,
                  itemBuilder: (context, index){
                    var user = userList[index];
                    return GestureDetector(
                      onTap: (){
                        print("Person: ${user.user_name} - ${user.user_name} - ${user.user_email}");
                        //Navigator.push(context, MaterialPageRoute(builder: (context)=> Message(person: person)));
                      },
                      child: Card(color: lightPrimaryColor,//Person message elementi
                        child: SizedBox(height: 60,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(user.user_name, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: primaryText),),
                                    Text(user.user_email, style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic,),),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              IconButton(onPressed: (){
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("${user.user_name} will be added your list. Are you sure?"),
                                      action: SnackBarAction(label: "Yes", onPressed: (){ context.read<AddPersonCubit>().addUser(user.user_id); }),)
                                );
                              }, icon: const Icon(Icons.add), color: Colors.black54,)
                            ],
                          ),
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
    );
  }
}

