import 'package:chatapp/services/auth/auth_service.dart';
import 'package:chatapp/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_textfield.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key, required this.ontap});
  //email controller
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  //ontap for navigation to register screen
  final void Function()? ontap;
//login method
  void login(BuildContext context) async{
    //get auth service
    final authService = AuthService();
    //try login
    try {
     await authService.singInWithEmailPassword(
          _emailController.text, _passwordController.text);
    }
    //catch
    catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("C H A T")),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
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
            "Welcome back!",
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
          const SizedBox(height: 20),
          //login button
          CustomButton(
            text: "L O G I N",
            onTap: () => login(context),
          ),
          const SizedBox(height: 20),
          //register now
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Not a member?"),
              //to show register screen
              GestureDetector(
                onTap: ontap,
                child: const Text(
                  "Register now",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
