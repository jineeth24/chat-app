import 'package:chatapp/services/auth/auth_service.dart';
import 'package:chatapp/widgets/custom_button.dart';
import 'package:chatapp/widgets/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {

  final _emailController=TextEditingController();
  final _passwordController=TextEditingController();
  final _confirmPasswordController=TextEditingController();
  //ontap for navigating to login screen
  final void Function()? ontap;
   RegisterScreen({super.key,required this.ontap});
// registration 
   void register(BuildContext context)async{
    final _auth=AuthService();
    //if password match
    if(_passwordController.text==_confirmPasswordController.text){
      try{
        await _auth.signUpWithEmailPassword(_emailController.text, _passwordController.text);
      }
      catch(e){
        showDialog(
        context: context,
        builder: (context) => AlertDialog(content: Text(e.toString())),
      );
      }
    }
    //password dont match
    else{
      showDialog(
        context: context,
        builder: (context) =>const AlertDialog(content: Text("Password dont match")),
      );

    }
    
   
   }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(title: const Text("C H A T")),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            //logo
            Icon(
              Icons.message,
              size: 60,
              color: Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(
              height: 25,
            ),
        
            //welcome message
            const Text(
              "Lets start chatting !",
              style: TextStyle(fontSize: 20),
            ),
        
            const SizedBox(height: 25),
            //email textfield
            CustomTextfield(
              hintText: "Email",
              obscureText: false,
              textController: _emailController,
            ),
            const SizedBox(height: 25),
        
            //password textfield
            CustomTextfield(
              hintText: "Password",
              obscureText: true,
              textController: _passwordController,
            ),
            const SizedBox(height: 25),
            //confirm  password textfield
            CustomTextfield(
              hintText: "Confirm Password",
              obscureText: true,
              textController: _confirmPasswordController,
            ),
            const SizedBox(height: 20),
            //login button
            CustomButton(
              text: "R E G I S T E R",
              onTap: ()=>register(context),
            ),
            const SizedBox(height: 20),
            //register now
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
             const   Text("Already have an account ?"),
             const   SizedBox(width: 5,),
                GestureDetector(
                  onTap: ontap,
                  child:const Text(
                    "Login now",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}