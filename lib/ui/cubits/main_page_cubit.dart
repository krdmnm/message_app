import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_app/data/entity/person.dart';
import 'package:message_app/data/repository/dao.dart';

class MainPageCubit extends Cubit<List<Person>>{
  MainPageCubit():super(<Person>[]);

  var dao = Dao();

  Future<void> getPersons() async {
    var persons = await dao.getPersons();
    emit(persons);
  }

  Future<void> searchPersons(String keyWord) async {
    var persons = await dao.searchPersons(keyWord);
    emit(persons);
  }

  Future<void> logOut(BuildContext context) async {
    dao.logOut(context);
  }



}