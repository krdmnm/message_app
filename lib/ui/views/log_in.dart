import 'package:flutter/material.dart';
import 'package:message_app/data/database/sb_database.dart';
import 'package:message_app/ui/cubits/log_in_cubit.dart';
import 'package:message_app/ui/materials/colors.dart';
import 'package:message_app/ui/views/sign_up.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  var tfUserEmail = TextEditingController();
  var tfUserPassword = TextEditingController();
  bool isObscured = true;



  Future<void> checkLogin() async {
    final sp = await SharedPreferences.getInstance();
    final email = sp.getString("email");
    final password = sp.getString("password");
    if(email != null && password != null){
      context.read<LoginCubit>().logIn(email, password, context);
    }
  }


  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: darkPrimaryColor, title: Text("Log In", style: TextStyle(color: white),),),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              TextField(controller: tfUserEmail, style: TextStyle(color: primaryText,) , decoration: InputDecoration(hintText: " Your E-Mail",border: OutlineInputBorder(),),),
              SizedBox(height:5),
              TextField(controller: tfUserPassword, obscureText: isObscured, style: TextStyle(color: primaryText,),
                decoration: InputDecoration(hintText: "Your Password",
                  border: OutlineInputBorder(),
                suffixIcon: IconButton(icon: Icon(isObscured ? Icons.visibility : Icons.visibility_off),
                  onPressed: (){
                  setState(() {
                    isObscured = !isObscured;
                  });
                  },),),),


              Padding(
                padding: const EdgeInsets.all(40),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: primaryColor, foregroundColor: white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7))),
                      onPressed: (){
                      context.read<LoginCubit>().logIn(tfUserEmail.text, tfUserPassword.text, context);
                    }, child: Text("LOG IN", style: TextStyle(color: white),), ),

                    Text("OR", style: TextStyle(fontSize: 16, color:Colors.black54, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),),

                    ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: primaryColor, foregroundColor: white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7))),
                        onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUp())).then((value){print("to LogIn from SignUp");});
                    }, child: Text("SIGN UP", style: TextStyle(color: white),)),

                  ],

                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}



/*
1)Önce textfielddaki verileri temizlesin

2)Sign in basıldığında veri tabanından kişiyi bulup kontrol etsin
  Kişi varsa şifreyi kontrol etsin şifre doğru mu yanlış mı bilgi versin
  Kişi yoksa kişi yok uyarısı versin


  */