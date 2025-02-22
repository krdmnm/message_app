import 'package:flutter/material.dart';
import 'package:message_app/ui/materials/colors.dart';
import 'package:message_app/ui/views/add_person.dart';
import 'package:message_app/ui/views/message.dart';
import '../../data/entity/person.dart';
// son gelen mesajlar ve kişileer burada listelenecek



class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isSearchActive = false;

  Future<void> search(String keyWord) async {
    //burası appBardaki arama ikonuna tıklandığında çalışacak bir liste dönecek ve bu liste main_page de gösterilecek
    print("Search: $keyWord");
  }

  Future<void> deletePerson(int personId) async {
    print("Delete: $personId");
  }

  Future<List<Person>> getPersons() async {
    //burası veritabanından liste döndürecek - önce user nesnesinden ekli olan kişi listesini alalım
    var persons = <Person>[];
    var p1 = Person(person_id: 1, person_name: "Ahmet", person_phone: "5555555555");
    var p2 = Person(person_id: 2, person_name: "Mehmet", person_phone: "5555555556");
    var p3 = Person(person_id: 3, person_name: "Ali", person_phone: "5555555557");
    var p4 = Person(person_id: 4, person_name: "Veli", person_phone: "5555555558");
    var p5 = Person(person_id: 5, person_name: "Can", person_phone: "5555555559");
    persons.add(p1);
    persons.add(p2);
    persons.add(p3);
    persons.add(p4);
    persons.add(p5);
    return persons;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: darkPrimaryColor,
        title: isSearchActive ? TextField(style: TextStyle(color: primaryText) ,decoration: const InputDecoration(hintText: "Search",), onChanged: (keyWord){search(keyWord);},)
          : Text("Messages", style: TextStyle(color: primaryText),),

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
        }, icon: Icon(Icons.search))
      ],),

      body: Container(color: white,
        child: FutureBuilder<List<Person>>(
            future: getPersons(),
            builder: (context, snapshot){
              if(snapshot.hasData){
                var personList = snapshot.data; //burada snapshottaki listeyi aldık
                return ListView.builder(
                  itemCount: personList!.length,
                  itemBuilder: (context, index){
                    var person = personList[index];
                    return GestureDetector(
                      onTap: (){
                        print("Person: ${person.person_name} - ${person.person_phone}");
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
                                    Text(person.person_phone, style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic,),),
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
        Navigator.push(context, MaterialPageRoute(builder: (context) => const AddPerson())).then((value)=>{print("to MainPage from AddPerson")});
      }, child: Icon(color: primaryText, Icons.person_add_alt_1_outlined)),


    );
  }
}

