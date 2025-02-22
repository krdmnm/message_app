import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_app/data/repository/dao.dart';

class LoginCubit extends Cubit<void>{
  LoginCubit():super(0);

  var dao = Dao();

  Future<void> logIn(String phone, String password) async {
    await dao.logIn(phone, password);
  }


}