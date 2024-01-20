import 'package:chatapp/screens/login_screen.dart';
import 'package:chatapp/screens/register_screen.dart';
import 'package:flutter/material.dart';
class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
//initially show login page
bool showLoginSrceen=true;

//toggle between login and reg
void togglesrceens(){
  setState(() {
    showLoginSrceen=!showLoginSrceen;
  });
}

  @override
  Widget build(BuildContext context) {
    if(showLoginSrceen){
      return LoginScreen(ontap: togglesrceens,);
    }else{
      return RegisterScreen(ontap: togglesrceens,);
    }
   // return Scaffold();
  }
}