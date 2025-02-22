import '../entity/person.dart';

class Dao {


  //login.dart
  Future<void> logIn(String phone, String password) async {
    if(phone.isNotEmpty && password.isNotEmpty){
      //veritabanından kişiyi bul - önce tel ve password temizle
      print("Phone: ${phone} - Password: ${password}");
    }else{
      //Snackbar ekle
    }
  }

  //sig_up.dart
  Future<void> signUp(String phone, String name, String password) async {
    if(phone.isNotEmpty && name.isNotEmpty && password.isNotEmpty){
      //veritabanına kaydet - önce verileri temizle
      print("Phone: $phone - Name: $name - Password: $password");
    }else{
      //Snackbar ekle
      print("TextField is empty");
    }
  }

  //main_page.dart - kayıtlı kişilerden aramak için
  Future<List<Person>> searchPersons(String keyWord) async {
    var persons = <Person>[];
    var person = Person(person_id: 1, person_name: "Ahmet", person_phone: "5555555555");
    persons.add(person);
    return persons;
  }


  //main_page.dart
  Future<List<Person>> getPersons() async {
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

}