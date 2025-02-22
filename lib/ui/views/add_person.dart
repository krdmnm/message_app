import 'package:flutter/material.dart';
import 'package:message_app/ui/materials/colors.dart';

class AddPerson extends StatefulWidget {
  const AddPerson({super.key});

  @override
  State<AddPerson> createState() => _AddPersonState();
}

class _AddPersonState extends State<AddPerson> {
  var tfPersonPhone = TextEditingController();
  var tfPersonName = TextEditingController();
  String person_info = "";


  Future<void> search() async {
    if(tfPersonPhone.text.isNotEmpty){
      person_info = tfPersonPhone.text;
    }else if (tfPersonName.text.isNotEmpty){
      person_info = tfPersonName.text;
    }else{
      //Snackbar ekle
    }
    print(person_info);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: darkPrimaryColor,
        title: Text("Add Your Firend", style: TextStyle(color: white),),),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 50, right: 50),
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [


              TextField(controller: tfPersonName,
                style: TextStyle(color: primaryText, fontSize: 12),
                decoration: const InputDecoration(hintText: "Your friend's 11 digit phone number", border: OutlineInputBorder(),),),

              Text("OR",style: TextStyle(fontSize: 20, color: primaryText, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),),

              TextField(controller: tfPersonPhone,
                style: TextStyle(color: primaryText, fontSize: 12),
                decoration: const InputDecoration(hintText: "Your friend's name", border: OutlineInputBorder(),),),

              ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: primaryColor, foregroundColor: white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),),
                onPressed: (){
              print("Name: $tfPersonPhone - $tfPersonName");
              search();
            }, child: Text("SEARCH", style: TextStyle(color: white),),),


            ],
          ),
        ),
      ),
    );
  }
}

/*
1) Önce phone numbera göre arama yap.
  Phone number boşsa ada göre arama yap
2)Çıkan sonuçları card olarak listele

3) ekle
 */