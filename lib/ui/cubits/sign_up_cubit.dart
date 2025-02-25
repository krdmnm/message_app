import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_app/data/repository/dao.dart';


class SignUpCubit extends Cubit<void>{

  SignUpCubit():super(0);

  var dao = Dao();

  Future<void> signUp(BuildContext context, String phone, String name, String password) async {
    await dao.signUp(context, phone, name, password);
  }

}