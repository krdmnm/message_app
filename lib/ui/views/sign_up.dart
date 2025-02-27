import 'package:flutter/material.dart';
import 'package:message_app/ui/cubits/sign_up_cubit.dart';
import 'package:message_app/ui/materials/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var tfUserEmail = TextEditingController();
  var tfUserName = TextEditingController();
  var tfUserPassword = TextEditingController();
  bool isObscured = true;


  Future<void> signUp() async {
    if(tfUserEmail.text.isNotEmpty && tfUserName.text.isNotEmpty && tfUserPassword.text.isNotEmpty){
      //veritabanına kaydet - önce verileri temizle
      print("Phone: ${tfUserEmail.text} - Name: ${tfUserName.text} - Password: ${tfUserPassword.text}");
    }else{
      //Snackbar ekle
      print("TextField is empty");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: darkPrimaryColor,title: Text("Sign Up", style: TextStyle(color: primaryText),),),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left:25, right: 25, top: 20),
          child: Column(mainAxisAlignment: MainAxisAlignment.start,
            children: [

              TextField(controller: tfUserEmail,
                decoration: InputDecoration(hintText: "Your unique email", border: OutlineInputBorder(),),),

              SizedBox(height:5),

              TextField(controller: tfUserName,
                decoration: InputDecoration(hintText: "Your non-unique name", border: OutlineInputBorder(),),),

              SizedBox(height:5),

              TextField(controller: tfUserPassword, obscureText: isObscured,
                decoration: InputDecoration(hintText: "Your password",
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(icon: Icon(isObscured ? Icons.visibility : Icons.visibility_off),
                    onPressed: (){
                      setState(() {
                        isObscured = !isObscured;
                      });
                    },),),),

              SizedBox(height:5),

              ElevatedButton(style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(primaryColor),), onPressed: (){
                context.read<SignUpCubit>().signUp(context, tfUserEmail.text, tfUserName.text, tfUserPassword.text);
              }, child: Text("SIGN UP", style: TextStyle(color: primaryText),),),

            ],
          ),
        ),
      ),
    );
  }
}


/*
1)textfielddaki verileri temizle

2)Telefon numarasını kontrol et
  varsa uyarı ver yoksa veritabanına kaydet
 */