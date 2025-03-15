import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:message_app/data/entity/person.dart';
import 'package:message_app/data/repository/dao.dart';

class AddPersonCubit extends Cubit<List<Person>>{
  AddPersonCubit():super(<Person>[]);

  var dao = Dao();

  Future<void> searchUser(String keyWord) async {
    final persons = await dao.searchUser(keyWord);
    print("AddPersonCuibt persons: $persons");
    emit(persons);
  }

  Future<void> logOut(BuildContext context) async {
    dao.logOut(context);
  }

  Future<void> addUser(String userId) async {
    await dao.addUser(userId);
  }



}