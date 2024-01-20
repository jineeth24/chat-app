import 'dart:async';

import 'package:chatapp/screens/chat_screen.dart';
import 'package:chatapp/services/auth/auth_service.dart';
import 'package:chatapp/services/chat/chat_service.dart';
import 'package:chatapp/widgets/custom_drawer.dart';
import 'package:chatapp/widgets/user_tile.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final chatService = ChatService();
  final authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: Colors.transparent,
        foregroundColor: const Color.fromARGB(255, 133, 130, 130),
        elevation: 0,
        centerTitle: true,
      ),
      drawer: const CustomDrawer(),
      body: buildUserList(),
    );
  }

  //build a list of users,for the chatlist except current users
  Widget buildUserList() {
    return StreamBuilder(
        stream: chatService.getUserStream(),
        builder: (context, snapshot) {
          //error
          if (snapshot.hasError) {
            return const Text("Error");
          }
          //loading..
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }
          return SizedBox(
            //
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: snapshot.data!
                    .map<Widget>(
                        (userData) => buildUserListItem(userData, context))
                    .toList(),
              ),
            ),
          );
        });
  }

//build individual user tile for user details
  Widget buildUserListItem(
      //return user
      Map<String, dynamic> userData,
      BuildContext context) {
    if (userData['email'] != authService.getCurrentUser()!.email) {
      return UserTile(
        // text: "user",
        text: userData["email"],
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: ((context) => ChatScreen(
                  recieverId: userData["uid"],
                  recieverEmail: userData["email"],
                )))),
      );
    } else {
      return Container();
    }
  }
}
