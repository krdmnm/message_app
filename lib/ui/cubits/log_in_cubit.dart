import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_app/data/repository/dao.dart';

class LoginCubit extends Cubit<void>{
  LoginCubit():super(0);

  var dao = Dao();

  Future<void> logIn(String email, String password, BuildContext context) async {
    await dao.logIn(email, password, context);
  }


}