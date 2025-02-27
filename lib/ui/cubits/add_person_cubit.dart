import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_app/data/entity/app_user.dart';
import 'package:message_app/data/repository/dao.dart';

class AddPersonCubit extends Cubit<List<AppUser>>{
  AddPersonCubit():super(<AppUser>[]);

  var dao = Dao();

  Future<void> searchUser(String keyWord) async {
    dao.searchUser(keyWord);
  }

  Future<void> logOut(BuildContext context) async {
    dao.logOut(context);
  }

  Future<void> addUser(String userId) async {
    await dao.addUser(userId);
  }



}