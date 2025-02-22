import 'package:flutter/material.dart';
import 'package:message_app/ui/cubits/add_person_cubit.dart';
import 'package:message_app/ui/cubits/log_in_cubit.dart';
import 'package:message_app/ui/cubits/main_page_cubit.dart';
import 'package:message_app/ui/cubits/sign_up_cubit.dart';
import 'package:message_app/ui/views/add_person.dart';
import 'package:message_app/ui/views/log_in.dart';
import 'package:message_app/ui/views/main_page.dart';
import 'package:message_app/ui/views/search_result.dart';
import 'package:message_app/ui/views/sign_up.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => SignUpCubit()),
        BlocProvider(create: (context) => AddPersonCubit()),
        BlocProvider(create: (context) => MainPageCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MainPage(),
      ),
    );
  }
}
