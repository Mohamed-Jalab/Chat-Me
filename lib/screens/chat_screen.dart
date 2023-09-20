import 'package:chat_app/cubits/chat_screen/cubit.dart';
import 'package:chat_app/cubits/chat_screen/states.dart';
import 'package:chat_app/screens/welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/message.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFF57F17),
          title: const Row(
            children: [
              Image(image: AssetImage('images/logo.png'), height: 40),
              SizedBox(width: 10),
              Text('Chat Me'),
            ],
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  if (context.mounted) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const WelcomeScreen(),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 63),
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('messages')
                        .orderBy('time')
                        .snapshots(),
                    builder: (context, snapshot) {
                      List<Map<String, dynamic>> data = [];
                      if (snapshot.connectionState != ConnectionState.waiting) {
                        for (QueryDocumentSnapshot<Map<String, dynamic>> doc
                            in snapshot.data!.docs) {
                          // List<bool> isMe = [false];
                          // fun(isMe, doc.get('username'));
                          // print(isMe);
                          data.add({
                            'isMe': doc.get('email')==FirebaseAuth.instance.currentUser!.email,
                            'text': doc.get('text'),
                            'username': doc.get('username')
                          });
                        }
                      }
                      return SingleChildScrollView(
                        reverse: true,
                        physics: const BouncingScrollPhysics(),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: data
                                .map((element) => Message(
                                      content: element['text'],
                                      isMe: element['isMe'],
                                      username: element['username'],
                                    ))
                                .toList(),
                          ),
                        ),
                      );
                    }),
              ),
              Positioned(
                bottom: 0,
                child: BlocConsumer<ChatCubit, ChatStates>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    ChatCubit cubit = BlocProvider.of(context);
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: cubit.messageController,
                                cursorColor: const Color(0xFF1565C0),
                                decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Color(0xFFEAEAEA),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    hintText: 'Type a message'),
                              ),
                            ),
                            const SizedBox(width: 5),
                            SizedBox(
                              height: 50,
                              child: FloatingActionButton(
                                backgroundColor: const Color(0xFF1565C0),
                                onPressed: cubit.sendMessage,
                                child: const Icon(Icons.send_rounded),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void fun(List<bool> b, String user) async {
  QuerySnapshot userRef = await FirebaseFirestore.instance
      .collection('users')
      .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
      .get();

  b = [userRef.docs[0].get('username') == user];
}
