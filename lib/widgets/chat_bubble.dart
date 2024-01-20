import 'package:chatapp/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  final sendTime;
  const ChatBubble(
      {super.key,
      required this.message,
      required this.isCurrentUser,
      required this.sendTime});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode=Provider.of<ThemeProvider>(context).isDarkMode;
    return Container(
      decoration: BoxDecoration(
          color: isCurrentUser
              ? isDarkMode?Color.fromARGB(255, 101, 172, 148):const Color.fromARGB(255, 158, 228, 162)//right
              : isDarkMode? Color.fromARGB(255, 138, 133, 133):Color.fromARGB(255, 203, 207, 203),//left
          borderRadius: BorderRadius.circular(5)),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(8),
      child: Text(
        message,style: GoogleFonts.karla(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontSize: 15,
              )
      ),
    );
  }
}
