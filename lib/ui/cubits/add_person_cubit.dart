import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_app/data/repository/dao.dart';

class AddPersonCubit extends Cubit<void>{
  AddPersonCubit():super(0);

  var dao = Dao();

  Future<void> search(String? personInfo) async {
    //await dao.search(personInfo);
  }

}