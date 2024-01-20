import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const CustomButton({super.key,required this.text,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin:const  EdgeInsets.symmetric(horizontal: 25),
        padding:const EdgeInsets.all(25),
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
           text,
          ),
        ),
      ),
    );
  }
}
