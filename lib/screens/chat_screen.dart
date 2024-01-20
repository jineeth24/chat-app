import 'package:chatapp/services/auth/auth_service.dart';
import 'package:chatapp/services/chat/chat_service.dart';
import 'package:chatapp/widgets/chat_bubble.dart';
import 'package:chatapp/widgets/custom_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen(
      {super.key, required this.recieverId, required this.recieverEmail});
  final String recieverId;
  final String recieverEmail;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  //message controller
  final TextEditingController messageController = TextEditingController();
  //scroll controller
  final ScrollController scrollController = ScrollController();

  //chat and authservices
  final chatService = ChatService();
  final authService = AuthService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
      const Duration(milliseconds: 500),
      () => scrollDown(),
    );
  }

  //send message
  void sendMessage() async {
    //if messagecontroller not empty
    if (messageController.text.isNotEmpty) {
      //send message
      chatService.sendMessage(widget.recieverId, messageController.text);
      //clear controller
      messageController.clear();
    }
  }

  void scrollDown() {
    // scrollController.jumpTo(scrollController.position.maxScrollExtent);
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recieverEmail),
        backgroundColor: Colors.transparent,
        foregroundColor: const Color.fromARGB(255, 133, 130, 130),
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(children: [
        //display all messages
        buildMessageList(),
        //user input
        buildUserInput(),
      ]),
    );
  }

  Widget buildMessageList() {
    String senderId = authService.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: chatService.getMessages(widget.recieverId, senderId),
        builder: (context, snapshot) {
          //errors
          if (snapshot.hasError) {
            return const Text("error");
          } //loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }
          //return listview
          return Expanded(
            child: ListView(
              reverse: true,
              // controller: scrollController,
              children: snapshot.data!.docs
                  .map((doc) => buildMessageItem(doc))
                  .toList()
                  .reversed
                  .toList(),
            ),
          );
        });
  }

  Widget buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//is current user, to align snd and recieve message on left and right
    bool isCurrentUser = data['senderId'] == authService.getCurrentUser()!.uid;

    //align  left and right
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
//convert timestamp to datetime12hrformat
    Timestamp timestamp = data['timestamp'];
    DateTime dateTime = timestamp.toDate();
    String formattedHourMinute = DateFormat('h:mm a').format(dateTime);

    return Container(
        alignment: alignment,
        padding: const EdgeInsets.all(6),
        //margin: const EdgeInsets.all(8),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ChatBubble(
              message: data["message"],
              isCurrentUser: isCurrentUser,
              sendTime: formattedHourMinute,
            ),
            Text(
              formattedHourMinute,
              style: const TextStyle(fontSize: 10),
            ),
          ],
        ));
  }

  //build message input==message textfield and send button
  Widget buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Row(
        children: [
          //textfield with max space
          Expanded(
            child: CustomTextfield(
              textController: messageController,
              hintText: "type a message",
              obscureText: false,
            ),
          ),
          //send button
          Container(
            decoration: BoxDecoration(
              color: Colors.green.shade200,
              shape: BoxShape.circle,
            ),
            margin: const EdgeInsets.only(right: 25),
            child: IconButton(
              onPressed: sendMessage,
              icon: const Icon(Icons.send),
            ),
          ),
        ],
      ),
    );
  }
}
