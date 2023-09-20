import 'package:chat_app/cubits/chat_screen/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit() : super(ChatInitialState());
  TextEditingController messageController = TextEditingController();
  List<Map<String, dynamic>> messages = [];
  void sendMessage() async {
    String text = messageController.text;
    messageController = TextEditingController(text: '');
    emit(ChatRestControllerState());
    QuerySnapshot<Map<String, dynamic>> query = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .get();
    await FirebaseFirestore.instance.collection('messages').add({
      'email': FirebaseAuth.instance.currentUser!.email,
      'text': text,
      'username': query.docs[0].data()['username'],
      'time': FieldValue.serverTimestamp(),
    });
  }

  void reciveMessages(QuerySnapshot<Map<String, dynamic>>? snapshot) {
    print('======================');
    for (QueryDocumentSnapshot<Map<String, dynamic>> snapshot
        in snapshot!.docs) {
      messages.add({
        'text': snapshot.data()['text'],
        'username': snapshot.data()['username'],
      });
    }
    print('======================');
    emit(ChatReciveMessagesState());
  }
}
