import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final String hintText;
 final bool obscureText;
 final TextEditingController textController;
  const CustomTextfield({
    super.key,
    required this.hintText,
    required this.obscureText,
    required this.textController,
  });

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal:25),
      child: TextField(
        obscureText: obscureText,
        controller: textController,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary)
          ),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:Theme.of(context).colorScheme.tertiary )),
          fillColor: Theme.of(context).colorScheme.secondary,
          filled: true,
        
        hintText: hintText,
        
        
      ),
    ),
    );
  }
}