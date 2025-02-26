import 'package:flutter/material.dart';
import 'package:message_app/data/database/sb_database.dart';
import 'package:message_app/data/entity/app_user.dart';
import 'package:message_app/ui/cubits/main_page_cubit.dart';
import 'package:message_app/ui/materials/colors.dart';
import 'package:message_app/ui/materials/views.dart';
import 'package:message_app/ui/views/add_person.dart';
import 'package:message_app/ui/views/message.dart';
import '../../data/entity/person.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'log_in.dart';
// son gelen mesajlar ve kişileer burada listelenecek



class MainPage extends StatefulWidget {
  AppUser user;
  MainPage({required this.user});
  //const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isSearchActive = false;

  Future<void> search(String keyWord) async {
    //burası appBardaki arama ikonuna tıklandığında çalışacak bir liste dönecek ve bu liste main_page de gösterilecek
    print("Search: $keyWord");
  }

  Future<void> deletePerson(String personId) async {
    print("Delete: $personId");
  }

  @override
  void initState() {
    super.initState();
    context.read<MainPageCubit>().getPersons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: darkPrimaryColor,
        title: isSearchActive ? TextField(style: TextStyle(color: primaryText) ,decoration: const InputDecoration(hintText: "Search",),
          onChanged: (keyWord){
          context.read<MainPageCubit>().searchPersons(keyWord);},)
          : Text("Messages of ${widget.user.user_name}", style: TextStyle(color: primaryText),),

        actions: [isSearchActive ?
        IconButton(onPressed: (){
          setState(() {
            isSearchActive = false;
            context.read<MainPageCubit>().getPersons();
          });
        }, icon: Icon(Icons.clear))

          :

        IconButton(onPressed: (){
          setState(() {
            isSearchActive = true;
          });
        }, icon: Icon(Icons.search)),
          Views(logOut: (context) {
            context.read<MainPageCubit>().logOut(context);
            //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LogIn()));
          },),
      ],),

      body: Container(color: white,
        child: BlocBuilder<MainPageCubit, List<Person>>(
            builder: (context, personsList){
              if(personsList.isNotEmpty){
                return ListView.builder(
                  itemCount: personsList.length,
                  itemBuilder: (context, index){
                    var person = personsList[index];
                    return GestureDetector(
                      onTap: (){
                        print("Person: ${person.person_name} - ${person.person_email}");
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Message(person: person)));
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
                                    Text(person.person_name, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: primaryText),),
                                    Text(person.person_email, style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic,),),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              IconButton(onPressed: (){
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("${person.person_name} will be deleted Are you sure?"),
                                    action: SnackBarAction(label: "Yes", onPressed: (){ deletePerson(person.person_id); }),)
                                );
                              }, icon: const Icon(Icons.clear), color: Colors.black54,)
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

      //Floating Action Button
      floatingActionButton: FloatingActionButton(backgroundColor: primaryColor, onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => const AddPerson())).then((value)=>{
          context.read<MainPageCubit>().getPersons()
        });
      }, child: Icon(color: primaryText, Icons.person_add_alt_1_outlined)),


    );
  }
}

